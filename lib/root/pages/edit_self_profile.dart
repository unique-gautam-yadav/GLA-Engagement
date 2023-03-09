import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../backend/auth.dart';
import '../../backend/models.dart';
import '../utils/utils.dart';

class EditSelfProfile extends StatefulWidget {
  const EditSelfProfile(
      {super.key, required this.profile, required this.getProfileData});

  final ProfileModel profile;

  final VoidCallback getProfileData;

  @override
  State<EditSelfProfile> createState() => _EditSelfProfileState();
}

class _EditSelfProfileState extends State<EditSelfProfile> {
  bool loadingCover = false;
  bool imageFile = false;

  TextEditingController bioController = TextEditingController();

  final picker = ImagePicker();
  XFile? coverImageFile;

  uploadProfileImage(ImageSource? src) async {
    setState(() {
      imageFile = true;
    });
    if (src != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      XFile? i = await picker.pickImage(source: src);
      if (i != null) {
        CroppedFile? f = await ImageCropper().cropImage(
            sourcePath: i.path,
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
        if (f != null) {
          Reference ref = storage
              .ref()
              .child("profilePictures")
              .child("${FirebaseAuth.instance.currentUser!.email!.hashCode}");
          await ref.putFile(File(f.path)).whenComplete(() async {
            String url = await ref.getDownloadURL();
            log(url);
            Map<String, dynamic> data = {};
            data = widget.profile.copyWith(imgUrl: url).toMap();
            if (context.mounted) {
              await Auth.updateUserData(data, context);
              widget.getProfileData();
            }
          });
        }
      }
      setState(() {
        imageFile = false;
      });
    }
  }

  uploadCoverImage(ImageSource? src) async {
    setState(() {
      loadingCover = true;
    });
    if (src != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      XFile? i = await picker.pickImage(source: src);
      if (i != null) {
        CroppedFile? f = await ImageCropper().cropImage(
            sourcePath: i.path,
            aspectRatio: const CropAspectRatio(ratioX: 137, ratioY: 40));
        if (f != null) {
          Reference ref = storage
              .ref()
              .child("coverPictures")
              .child("${FirebaseAuth.instance.currentUser!.email!.hashCode}");
          await ref.putFile(File(f.path)).whenComplete(() async {
            String url = await ref.getDownloadURL();
            log(url);
            Map<String, dynamic> data = {};
            data = widget.profile.copyWith(coverImage: url).toMap();
            if (context.mounted) {
              await Auth.updateUserData(data, context);
              widget.getProfileData();
            }
          });
        }
      }
      setState(() {
        loadingCover = false;
      });
    }
  }

  selectPicker(Function next) {
    showModalBottomSheet(
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
                    next(ImageSource.camera);
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
                    next(ImageSource.gallery);
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
  }

  @override
  Widget build(BuildContext context) {
    bioController.text = widget.profile.desc ?? "";

    return Scaffold(
      appBar: AppBar(title: Text(widget.profile.name ?? "no name")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                border: Border.all(),
                              ),
                              width: double.infinity,
                              child: !loadingCover
                                  ? widget.profile.coverImage != null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  widget.profile.coverImage!),
                                            ),
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors
                                                              .grey.shade100)),
                                              onPressed: () {
                                                selectPicker(uploadCoverImage);
                                              },
                                              icon: const Icon(
                                                  Icons.upload_rounded),
                                            ),
                                          ),
                                        )
                                      : MaterialButton(
                                          onPressed: () {
                                            selectPicker(uploadCoverImage);
                                          },
                                          child: Center(
                                            child: IconButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors
                                                              .grey.shade100)),
                                              onPressed: () {
                                                selectPicker(uploadCoverImage);
                                              },
                                              icon: const Icon(
                                                  Icons.upload_rounded),
                                            ),
                                          ),
                                        )
                                  : const SpinKitCircle(
                                      color: Colors.green,
                                      size: 35,
                                    ),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            left: 20,
                            child: Container(
                              width: 120,
                              height: 120,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(500),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(500),
                                child: MaterialButton(
                                  onPressed: () {
                                    selectPicker(uploadProfileImage);
                                  },
                                  child: !imageFile
                                      ? widget.profile.imgUrl != null
                                          ? Container(
                                              height: 120,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      widget.profile.imgUrl!),
                                                ),
                                              ),
                                              child: Center(
                                                child: IconButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.grey
                                                                  .shade100)),
                                                  onPressed: () {
                                                    selectPicker(
                                                        uploadProfileImage);
                                                  },
                                                  icon: const Icon(
                                                      Icons.upload_rounded),
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child: IconButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.grey.shade100),
                                              ),
                                              onPressed: () {
                                                selectPicker(
                                                    uploadProfileImage);
                                              },
                                              icon: const Icon(
                                                  Icons.upload_rounded),
                                            ))
                                      : const SpinKitCircle(
                                          color: Colors.green,
                                          size: 35,
                                        ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      initialValue: widget.profile.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: "Full Name",
                          hintText: "Enter your full name"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.profile.mail,
                      enabled: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: "E-Mail",
                          hintText: "Enter your mail address"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      enabled: false,
                      initialValue: widget.profile.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: "Phone",
                          hintText: "Enter your phone number"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue:
                          "${widget.profile.course} - ${widget.profile.branch} (${widget.profile.sem ?? ""} Sem )",
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: "Course",
                          hintText: "Your course"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: bioController,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: "Bio",
                          hintText: "Enter something about you"),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPage(),
                    ));
              },
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
