import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glaengage/backend/auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  File? imageFile;
  TextEditingController caption = TextEditingController();

  bool processing = false;

  firstStep() async {
    ImageSource? src;
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).bottomSheetTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          width: double.infinity,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Choose image source"),
              const Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                child: Divider(),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    src = ImageSource.camera;
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    height: 110,
                    width: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                            color: Colors.grey.shade300,
                            child: const SizedBox(
                                height: 70,
                                width: 70,
                                child: Center(
                                    child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 30,
                                )))),
                        const Text("Camera"),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    src = ImageSource.gallery;
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    height: 110,
                    width: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                            color: Colors.grey.shade300,
                            child: const SizedBox(
                                height: 70,
                                width: 70,
                                child: Center(
                                    child: Icon(
                                  Icons.photo,
                                  size: 30,
                                )))),
                        const Text("Gallery"),
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        );
      },
    );
    if (src != null) {
      secondStep(src!);
    } else {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  secondStep(ImageSource src) async {
    XFile? uFile = await ImagePicker().pickImage(source: src);
    if (uFile != null) {
      CroppedFile? cFile = await ImageCropper().cropImage(
          sourcePath: uFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4));
      if (cFile != null) {
        setState(() {
          imageFile = File(cFile.path);
        });
      } else {
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } else {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  thirdStep() async {
    setState(() {
      processing = true;
    });
    String pID = await Auth.uploadPost(caption.text);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref("posts")
        .child(FirebaseAuth.instance.currentUser!.email!)
        .child(pID);
    await ref.putFile(imageFile!).whenComplete(() async {
      String url = await ref.getDownloadURL();
      log(url);
      await Auth.putFileToPost(pID, url);
      if (context.mounted) {
        Navigator.pop(context);
      }
    });
    setState(() {
      processing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      firstStep();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Post")),
      body: imageFile != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    child: Image.file(imageFile!),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                    controller: caption,
                    maxLines: 8,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      label: const Align(
                          alignment: Alignment.topLeft, child: Text("Caption")),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (processing) {
                      } else {
                        thirdStep();
                      }
                    },
                    child: !processing
                        ? const Text(
                            "Post",
                            style: TextStyle(color: Colors.white),
                          )
                        : const SpinKitCircle(color: Colors.white, size: 25),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
