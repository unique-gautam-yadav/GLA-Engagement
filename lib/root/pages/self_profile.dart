import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gla_engage/backend/auth.dart';
import 'package:gla_engage/backend/models.dart';
import 'package:gla_engage/backend/providers.dart';
import 'package:gla_engage/root/pages/edit_self_profile.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SelfProfile extends StatefulWidget {
  const SelfProfile({super.key});

  @override
  State<SelfProfile> createState() => _SelfProfileState();
}

class _SelfProfileState extends State<SelfProfile> {
  // final double profileImageHeight = 120;
  ProfileModel? model;

  bool loadingProfilePic = false;
  bool loadingCover = false;

  final ImagePicker picker = ImagePicker();

  String? userType;

  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "white sneaker with adidas logo",
      "price": "255",
      "images":
          "https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80",
    },
    {
      "title": "Black Jeans with blue stripes",
      "price": "245",
      "images":
          "https://images.unsplash.com/photo-1541099649105-f69ad21f3246?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "Red shoes with black stripes",
      "price": "155",
      "images":
          "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    },
    {
      "title": "Gamma shoes with beta brand.",
      "price": "275",
      "images":
          "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "Alpha t-shirt for alpha testers.",
      "price": "25",
      "images":
          "https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "Beta jeans for beta testers",
      "price": "27",
      "images":
          "https://images.unsplash.com/photo-1602293589930-45aad59ba3ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "V&V  model white t shirts.",
      "price": "55",
      "images":
          "https://images.unsplash.com/photo-1554568218-0f1715e72254?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    }
  ];

  uploadProfileImage(ImageSource? src) async {
    setState(() {
      loadingProfilePic = true;
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
          await ref.putFile(File(i.path)).whenComplete(() async {
            String url = await ref.getDownloadURL();
            log(url);
            Map<String, dynamic> data = {};
            data = model!.copyWith(imgUrl: url).toMap();
            if (context.mounted) {
              await Auth.updateUserData(data, context);
              getProfileData();
            }
          });
        }
      }
      setState(() {
        loadingProfilePic = false;
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
            data = model!.copyWith(coverImage: url).toMap();
            if (context.mounted) {
              await Auth.updateUserData(data, context);
              getProfileData();
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

  void getProfileData() {
    String uT = Provider.of<UserProvider>(context, listen: false).getUserType;

    setState(() {
      userType = uT;
    });
    Map<String, dynamic>? data =
        Provider.of<UserProvider>(context, listen: false).userToMap;

    setState(() {
      model = ProfileModel.fromMap(data!);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final top = coverImageHeight - profileImageHeight / 2;
    // final bottom = profileImageHeight / 2 - 35;
    return Column(
      children: model != null
          ? [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: Container(
                                  width: double.infinity,
                                  height: 120,
                                  color: Colors.grey,
                                  child: !loadingCover
                                      ? model!.coverImage != null
                                          ? InkWell(
                                              onLongPress: () {
                                                selectPicker(uploadCoverImage);
                                              },
                                              child: Image.network(
                                                model!.coverImage!,
                                                // width: double.infinity,
                                                // height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : MaterialButton(
                                              onPressed: () {
                                                selectPicker(uploadCoverImage);
                                              },
                                              child: SizedBox(
                                                // width: double.infinity,
                                                // height: 120,
                                                child: Center(
                                                    child: IconButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .white)),
                                                  onPressed: () {
                                                    selectPicker(
                                                        uploadCoverImage);
                                                  },
                                                  icon: const Icon(
                                                      Icons.file_upload,
                                                      size: 25),
                                                )),
                                              ),
                                            )
                                      : const SpinKitCircle(
                                          color: Colors.green,
                                          size: 35,
                                        ),
                                )),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Container(
                                height: 120,
                                width: 120,
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(500),
                                  child: !loadingProfilePic
                                      ? model!.imgUrl != null
                                          ? MaterialButton(
                                              onPressed: null,
                                              onLongPress: () {
                                                selectPicker(
                                                    uploadProfileImage);
                                              },
                                              child: SizedBox(
                                                height: 120,
                                                width: 120,
                                                child: Image.network(
                                                  model!.imgUrl!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : MaterialButton(
                                              onPressed: () {
                                                selectPicker(
                                                    uploadProfileImage);
                                              },
                                              child: const Icon(Icons.person_2,
                                                  size: 55))
                                      : const SpinKitCircle(
                                          color: Colors.green,
                                          size: 45,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 15, left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${model!.name}  ",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: OutlinedButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditSelfProfile(
                                              profile: model!,
                                              getProfileData: getProfileData,
                                            ),
                                          )),
                                      child: const Icon(Icons.edit_note_rounded,
                                          color: Colors.green)),
                                ),
                              ],
                            ),
                            Text(
                              "${model!.desc ?? ""} ",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildButton(keyword: "POST", value: 3),
                            const Divider(height: 2),
                            buildButton(keyword: "FOLLOWER", value: 1200),
                            const Divider(
                              height: 2,
                            ),
                            buildButton(keyword: "FOLLOWING", value: 200),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 10, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "assets/images/github.svg",
                              height: 40,
                              width: 40,
                            ),
                            SvgPicture.asset(
                              "assets/images/linkedin.svg",
                              height: 40,
                              width: 40,
                            ),
                            SvgPicture.asset(
                              "assets/images/twitter.svg",
                              height: 40,
                              width: 40,
                            ),
                            SvgPicture.asset(
                              "assets/images/instagram.svg",
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              const Divider(),
              GridView.builder(
                  padding: const EdgeInsets.all(10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: MediaQuery.of(context).size.width / 3,
                  ),
                  itemCount: gridMap.length,
                  itemBuilder: (_, index) {
                    return Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(left: 2, right: 2, bottom: 4),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(.5)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${gridMap.elementAt(index)['images']}"))),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              CupertinoIcons.heart_fill,
                              size: 17,
                            ),
                            Text(
                              "${gridMap.elementAt(index)['price']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ]
          : const [
              Center(
                child: SpinKitCircle(
                  color: Colors.green,
                  size: 55,
                ),
              )
            ],
    );
  }

  Widget buildButton({required String keyword, required int value}) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () => {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('$value',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(
              keyword,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      );
}
