import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gla_engage/backend/auth.dart';

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
  });

  final Map<String, dynamic> e;
  final ProfileModel profileData;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool liked = false;
  bool showAdded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              ///
              ///
              ///
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
            margin: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.width - 40) * (4 / 3),
            decoration: BoxDecoration(
                color: Colors.green.shade200,
                image: DecorationImage(
                    image: NetworkImage("${widget.e['imgUrl']}"))),
            child: showAdded
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 1, right: 1),
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Added to Liked",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(CupertinoIcons.heart_fill,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(child: Text("${widget.e['caption']}")),
                const SizedBox(width: 5),
                OutlinedButton(
                  onPressed: () async {
                    if (!liked) {
                      setState(() {
                        liked = true;
                      });
                      await Auth.likePost(widget.e['postID']);
                      setState(() {
                        showAdded = true;
                      });
                      Future.delayed(const Duration(seconds: 2)).then((value) {
                        setState(() {
                          showAdded = false;
                        });
                      });
                    } else {
                      await Auth.unLikePost(widget.e['postID']);
                      setState(() {
                        liked = false;
                        showAdded = false;
                      });
                    }
                  },
                  child: liked
                      ? const Icon(CupertinoIcons.heart_fill)
                      : const Icon(CupertinoIcons.heart),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
