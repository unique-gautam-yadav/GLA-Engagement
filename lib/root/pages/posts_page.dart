import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glaengage/backend/auth.dart';
import 'package:glaengage/root/pages/public_profile.dart';
import 'package:lottie/lottie.dart';

import '../../backend/models.dart';

class PostsFromProfile extends StatefulWidget {
  const PostsFromProfile(
      {super.key,
      required this.posts,
      required this.currentIndex,
      required this.profileData});

  final List<Map<String, dynamic>> posts;
  final ProfileModel profileData;
  final int currentIndex;

  @override
  State<PostsFromProfile> createState() => _PostsFromProfileState();
}

class _PostsFromProfileState extends State<PostsFromProfile> {
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.animateTo((630 * widget.currentIndex).toDouble(),
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: widget.posts
              .map(
                (e) => PostCard(e: e, profileData: widget.profileData),
              )
              .toList(),
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.e,
    required this.profileData,
    this.fromProfile,
  });

  final Map<String, dynamic> e;
  final ProfileModel profileData;
  final bool? fromProfile;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool liked = false;
  bool showAdded = false;
  int likeCounter = 0;

  likePost() async {
    if (!liked) {
      setState(() {
        likeCounter += 1;
        showAdded = true;
        liked = true;
      });
      Future.delayed(const Duration(seconds: 2)).then((value) {
        setState(() {
          showAdded = false;
        });
      });
      await Auth().likePost(widget.e['postID']);
    } else {
      setState(() {
        liked = false;
        showAdded = false;
        likeCounter -= 1;
      });
      await Auth().unLikePost(widget.e['postID']);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.e['likes'] == null) {
        setState(() {
          likeCounter = 0;
        });
      } else {
        setState(() {
          likeCounter = widget.e['likes'].length;
        });
      }
      if (widget.e['likes'] != null) {
        var temp = widget.e['likes'] as List<dynamic>;
        if (temp.contains(FirebaseAuth.instance.currentUser!.email!)) {
          setState(() {
            liked = true;
          });
        }
      } else {
        setState(() {
          liked = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            if (widget.fromProfile == null || widget.fromProfile == true) {
              Navigator.pop(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PublicProfile(email: widget.profileData.mail!),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: widget.profileData.imgUrl != null
                      ? NetworkImage(widget.profileData.imgUrl!)
                      : null,
                  child: widget.profileData.imgUrl == null
                      ? const Icon(Icons.person_3)
                      : null,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.profileData.name}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.profileData.type!.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.width - 20) * (4 / 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(children: [
            widget.e['imgUrl'] != null
                ? GestureDetector(
                    onDoubleTap: () {
                      likePost();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: widget.e['imgUrl'],
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor.withOpacity(.1)),
                    child: const Center(child: Text("Can't load image!!")),
                  ),
            // showAdded
            //     ? Align(
            //         alignment: Alignment.bottomCenter,
            //         child: Container(
            //           margin: const EdgeInsets.only(top: 20, left: 1, right: 1),
            //           width: MediaQuery.of(context).size.width,
            //           height: 30,
            //           decoration: const BoxDecoration(color: Colors.black),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: const [
            //               Padding(
            //                 padding: EdgeInsets.only(left: 5),
            //                 child: Text(
            //                   "Added to Liked",
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.only(right: 5),
            //                 child: Icon(CupertinoIcons.heart_fill,
            //                     color: Colors.white),
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            // : const SizedBox.shrink(),
            showAdded
                ? Align(
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      "assets/lotties/like.json",
                      repeat: false,
                    ),
                  )
                : const SizedBox.shrink(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Column(
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(122)),
                    minWidth: 0,
                    padding: const EdgeInsets.all(10),
                    onPressed: () {
                      likePost();
                    },
                    child: liked
                        ? const Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.red,
                          )
                        : const Icon(
                            CupertinoIcons.heart,
                            color: Colors.red,
                          ),
                  ),
                  Text("$likeCounter")
                ],
              ),
              const SizedBox(width: 5),
              Expanded(child: Text("${widget.e['caption']}")),
            ],
          ),
        ),
      ],
    );
  }
}
