import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:glaengage/backend/backend.dart';
import 'package:glaengage/backend/models.dart';
import 'package:glaengage/root/pages/posts_page.dart';
import 'package:glaengage/root/pages/public_profile.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomePagePosts>? data;
  List<ProfileModel>? recom;

  getData() async {
    data ??= [];
    List<HomePagePosts> temp = await BackEnd.getSuggestedPosts(context);

    if (mounted) {
      if (temp.isNotEmpty) {
        setState(() {
          data = temp;
        });
      } else {
        temp = await BackEnd.getRandomPosts();
        setState(() {
          data = temp;
        });
      }
    }
  }

  getOthers() async {
    List<ProfileModel>? r = await BackEnd.getSuggestedAccounts2(context);
    List<HomePagePosts> temp1 = await BackEnd.getFollowersPost();
    if (mounted) {
      setState(() {
        data!.addAll(temp1);
        recom = r;
      });
    }
  }

  ///
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
      getOthers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Column(
          children: [
            recom != null && recom!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: ListView.builder(
                        itemCount: recom!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PublicProfile(
                                          email: recom!.elementAt(index).mail!),
                                    ));
                              },
                              padding: const EdgeInsets.all(0),
                              minWidth: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                // margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      width: 75,
                                      child: CircleAvatar(
                                        backgroundImage: recom!
                                                    .elementAt(index)
                                                    .imgUrl !=
                                                null
                                            ? NetworkImage(
                                                recom!.elementAt(index).imgUrl!)
                                            : null,
                                        child: recom!.elementAt(index).imgUrl ==
                                                null
                                            ? const Icon(Icons.person_3)
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      "${recom!.elementAt(index).name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    Text(
                                      recom!
                                          .elementAt(index)
                                          .type!
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            data != null
                ? Column(
                    children: data!.map((e) {
                      return PostCard(
                          e: e.post!.toMap(),
                          profileData: e.profile!,
                          fromProfile: false);
                    }).toList(),
                    // children: [
                    //   PostCard(
                    //       e: data!.first.post!.toMap(),
                    //       profileData: data!.first.profile!)
                    // ],
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(.25),
                    highlightColor: Colors.white.withOpacity(.6),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.9),
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.9),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 10,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.9),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            width: MediaQuery.of(context).size.width,
                            height: (MediaQuery.of(context).size.width - 20) *
                                (4 / 3),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.9),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.9),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                width: 200,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.9),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
