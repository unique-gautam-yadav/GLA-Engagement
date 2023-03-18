import 'package:flutter/material.dart';
import 'package:glaengage/backend/models.dart';
import 'package:glaengage/root/pages/posts_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../backend/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomePagePosts>? data;

  getData() async {
    ///
    ///
    ///
    ///
    ///
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Column(
          children: [
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
