import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart' as valdi;
import 'package:gla_engage/backend/auth.dart';
import 'package:gla_engage/backend/models.dart';
import 'package:gla_engage/backend/providers.dart';
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

  TextEditingController bioController = TextEditingController();

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: model != null
          ? [
              Container(
                decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    boxShadow: const [
                      BoxShadow(blurRadius: 1),
                    ],
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 180,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: SizedBox(
                                width: double.infinity,
                                height: 120,
                                // color: Colors.blueGrey,
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
                                              fit: BoxFit.fitWidth,
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
                                                            .all(Colors.white)),
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
                                              selectPicker(uploadProfileImage);
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
                                              selectPicker(uploadProfileImage);
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
                            children: [
                              Text(
                                "${model!.name}  ",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              !FirebaseAuth.instance.currentUser!.emailVerified
                                  ? MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      height: 2,
                                      padding: EdgeInsets.zero,
                                      splashColor: Colors.red.shade300,
                                      onPressed: () async {
                                        try {
                                          await FirebaseAuth
                                              .instance.currentUser!
                                              .sendEmailVerification();
                                        } on FirebaseAuthException catch (e) {
                                          log(e.code);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 2,
                                            bottom: 2,
                                            left: 8,
                                            right: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red.shade900),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          "mail not varified",
                                          style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  softWrap: true,
                                  "${model!.desc ?? ""} ",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  bioController.text = model!.desc ?? "";
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12))),
                                    builder: (context) => Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        height: 250,
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12))),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                  height: 5,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(.9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  )),
                                              const SizedBox(height: 20),
                                              TextFormField(
                                                maxLength: 250,
                                                controller: bioController,
                                                maxLines: 3,
                                                decoration: InputDecoration(
                                                  labelText: "Bio",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                  child: SizedBox.expand()),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          200)))),
                                                  onPressed: () async {
                                                    await Auth.updateUserData(
                                                        model!
                                                            .copyWith(
                                                                desc:
                                                                    bioController
                                                                        .text)
                                                            .toMap(),
                                                        context);
                                                    getProfileData();
                                                    if (context.mounted) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Update",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ]),
                                      ),
                                    ),
                                  );
                                },
                                splashColor: Colors.green.shade300,
                                padding: EdgeInsets.zero,
                                minWidth: 1,
                                height: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 2, bottom: 2),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(.6)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          CusButton(keyword: "POST", value: 3),
                          CusButton(keyword: "FOLLOWER", value: 1200),
                          CusButton(keyword: "FOLLOWING", value: 200),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        "Social Links",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: model!.socialLinks != null &&
                                      model!.socialLinks!.isNotEmpty
                                  ? model!.socialLinks!
                                      .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: ProfileLink(
                                              e: e,
                                              model: model!,
                                              getProfileData: getProfileData)))
                                      .toList()
                                  : [],
                            ),
                            AddSocialButton(
                                model: model!, getProfileData: getProfileData)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const Text("Archiements or Jobs"),
              model!.achievements != null && model!.achievements!.isNotEmpty
                  ? AchievementCard(
                      getProfileData: getProfileData,
                      model: model!,
                      index: 0,
                    )
                  : Text("No achievement added !!",
                      style: TextStyle(
                        color: Colors.red.shade900,
                      )),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.show_chart),
                    onPressed: model!.achievements != null &&
                            model!.achievements!.length > 1
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllAchievements(
                                        getProfileData: getProfileData,
                                        model: model!)));
                          }
                        : null,
                    label: const Text("view more"),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewAchievement(
                                  model: model!,
                                  getProfileData: getProfileData)));
                    },
                    label: const Text("add new"),
                  ),
                ],
              ),
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
                              Border.all(color: Colors.black.withOpacity(.6)),
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
}

class AchievementCard extends StatefulWidget {
  const AchievementCard({
    super.key,
    required this.model,
    required this.getProfileData,
    required this.index,
  });

  final int index;
  final ProfileModel model;
  final VoidCallback getProfileData;

  @override
  State<AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<AchievementCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        splashColor: Colors.green.shade300,
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => SizedBox(
              height: 85,
              child: Column(
                children: [
                  Container(
                    height: 5,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.6),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  OutlinedButton(
                      onPressed: () async {
                        await Auth.removeAchievement(
                            data: widget.model.achievements!
                                .elementAt(widget.index),
                            context: context,
                            user: widget.model);
                        widget.getProfileData();
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Remove"))
                ],
              ),
            ),
          );
        },
        onPressed: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 700,
          height: isExpanded ? 160 : 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(.6))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  "${widget.model.achievements!.elementAt(widget.index)['title']}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  "${widget.model.achievements!.elementAt(widget.index)['briefDesc']}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              isExpanded
                  ? Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.black.withOpacity(.6),
                    )
                  : const SizedBox.shrink(),
              isExpanded
                  ? Flexible(
                      flex: 4,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "${widget.model.achievements!.elementAt(widget.index)['detaiedDesc']}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

///
///
///
///

class CusButton extends StatelessWidget {
  const CusButton({
    super.key,
    required this.value,
    required this.keyword,
  });

  final int value;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
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
}

class ProfileLink extends StatelessWidget {
  const ProfileLink(
      {super.key,
      required this.e,
      required this.model,
      required this.getProfileData});

  final Map<String, dynamic> e;
  final ProfileModel model;
  final VoidCallback getProfileData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SizedBox(
                height: 85,
                child: Column(
                  children: [
                    Container(
                      height: 5,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.6),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    OutlinedButton(
                        onPressed: () async {
                          await Auth.removeSocialLinkToProfile(
                              data: e, context: context, user: model);
                          getProfileData();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Remove"))
                  ],
                ),
              ),
            );
          },
          onPressed: () async {
            try {
              Uri r = Uri.parse(e['url']);
              await launchUrl(r, mode: LaunchMode.inAppWebView);
            } catch (e) {
              log("$e");
            }
          },
          minWidth: 2,
          splashColor: Colors.green.shade300,
          child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.withOpacity(.6)),
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(
                Icons.link,
                color: Colors.green,
              )),
        ),
        Text(e['title'])
      ],
    );
  }
}

class AddSocialButton extends StatelessWidget {
  const AddSocialButton(
      {super.key, required this.model, required this.getProfileData});

  final ProfileModel model;
  final VoidCallback getProfileData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          padding: EdgeInsets.zero,
          minWidth: 2,
          splashColor: Colors.green.shade300,
          onPressed: () {
            final fKey = GlobalKey<FormState>();
            TextEditingController title = TextEditingController();
            TextEditingController url = TextEditingController();
            showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              context: context,
              builder: (context) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 300,
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: fKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width / 4,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                        TextFormField(
                          controller: title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            } else if (value.length < 3) {
                              return "Title must have at least 3 char";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Title",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: url,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            } else if (!valdi.isURL(value)) {
                              return "Invalid url";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Url",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        const Expanded(child: SizedBox.expand()),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)))),
                            onPressed: () async {
                              if (fKey.currentState!.validate()) {
                                SocialLinkModel link = SocialLinkModel(
                                    title: title.text, url: url.text);
                                await Auth.addSocialLinkToProfile(
                                    data: link.toMap(),
                                    context: context,
                                    user: model);
                                if (context.mounted) {
                                  getProfileData();
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.black.withOpacity(.6)),
              ),
              child: const Center(child: Icon(Icons.add))),
        ),
        const Text("Add"),
      ],
    );
  }
}

class AllAchievements extends StatelessWidget {
  const AllAchievements(
      {super.key, required this.model, required this.getProfileData});

  final ProfileModel model;
  final VoidCallback getProfileData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievements"),
      ),
      body: ListView.builder(
        itemCount: model.achievements!.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AchievementCard(
                  index: index, model: model, getProfileData: getProfileData));
        },
      ),
    );
  }
}

class NewAchievement extends StatefulWidget {
  const NewAchievement(
      {super.key, required this.model, required this.getProfileData});

  final ProfileModel model;
  final VoidCallback getProfileData;

  @override
  State<NewAchievement> createState() => _NewAchievementState();
}

class _NewAchievementState extends State<NewAchievement> {
  TextEditingController title = TextEditingController();
  TextEditingController briefD = TextEditingController();
  TextEditingController detailD = TextEditingController();

  bool processing = false;

  final fKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Achievement"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: fKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else if (value.length < 3) {
                            return "Title must have at least 3 char";
                          } else {
                            return null;
                          }
                        },
                        controller: title,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            labelText: "Title of Achievement/job"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else if (value.length < 3) {
                            return "Description must have at least 3 char";
                          } else {
                            return null;
                          }
                        },
                        maxLines: 2,
                        controller: briefD,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            labelText: "Brief description of Achievement/job"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        maxLines: 3,
                        controller: detailD,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            labelText:
                                "Detailed description of Achievement/job"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const Expanded(child: SizedBox.shrink()),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    processing = !processing;
                  });
                  if (fKey.currentState!.validate()) {
                    AchievementModel data = AchievementModel(
                        title: title.text,
                        briefDesc: briefD.text,
                        detaiedDesc: detailD.text);
                    await Auth.addAchievement(
                        data: data.toMap(),
                        context: context,
                        user: widget.model);
                    widget.getProfileData();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                  setState(() {
                    processing = !processing;
                  });
                },
                child: !processing
                    ? const Expanded(
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : const Expanded(
                        child: SpinKitCircle(
                        color: Colors.white,
                        size: 25,
                      ))),
            MediaQuery.of(context).viewInsets.bottom < 10
                ? const SizedBox(height: 50)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
