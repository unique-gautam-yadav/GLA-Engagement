import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glaengage/backend/backend.dart';
import 'package:glaengage/root/pages/chat_screen.dart';
import 'package:glaengage/root/pages/profileshimmer.dart';
import 'package:lottie/lottie.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:glaengage/backend/auth.dart';
import 'package:glaengage/backend/models.dart';

import '../../backend/keywords.dart';
import 'posts_page.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({super.key, required this.email});

  final String email;

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  ProfileModel? model;
  List<Map<String, dynamic>>? posts;
  String? userType;
  Color? appBarColor;
  Color? iconColor;
  UserDetails? userDetails;
  bool followProcess = false;
  List<String>? mutuals;

  void getProfileData() async {
    ProfileModel? temp = await Auth.getProfileByMail(widget.email);
    UserDetails temp2 = await BackEnd.getUserDetial(widget.email);
    List<String> m = await BackEnd.getMutualUser(temp2);
    if (mounted) {
      setState(() {
        userDetails = temp2;
        model = temp;
        mutuals = m;
      });

      if (model!.coverImage != null) {
        PaletteGenerator d = await PaletteGenerator.fromImageProvider(
            maximumColorCount: 5, NetworkImage(model!.coverImage!));
        if (mounted) {
          setState(() {
            appBarColor = Color.alphaBlend(d.colors.first, d.colors.last);
          });
        }
        if (ThemeData.estimateBrightnessForColor(appBarColor!) ==
            Brightness.light) {
          iconColor = Colors.black;
        } else {
          iconColor = Colors.white;
        }
      }
    }
  }
  getPosts() async {
    List<Map<String, dynamic>> temp =
        await Auth.getAllPostsByMail(widget.email);

    setState(() {
      posts = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProfileData();
      getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: model != null && userDetails != null
              ? [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 3, color: Colors.grey.shade700),
                        const BoxShadow(blurRadius: 1, color: Colors.white),
                      ],
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 180,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.blueGrey))),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 120,
                                  child: model!.coverImage != null
                                      ? Image.network(
                                          model!.coverImage!,
                                          fit: BoxFit.cover,
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                              Positioned(
                                top: 60,
                                left: 20,
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.blueGrey)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: model!.imgUrl != null
                                          ? SizedBox(
                                              height: 120,
                                              width: 120,
                                              child: Image.network(
                                                model!.imgUrl!,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const Icon(Icons.person_2,
                                              size: 55)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 15, left: 15),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${model!.name}  ",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
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
                            ],
                          ),
                        ),
                        widget.email != FirebaseAuth.instance.currentUser!.email
                            ? ButtonBar(
                                children: [
                                  userDetails!.followers == null ||
                                          !userDetails!.followers!.contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.email)
                                      ? OutlinedButton.icon(
                                          onPressed: () async {
                                            await BackEnd.follow(model!.mail!);
                                            userDetails!.followers ??= [];
                                            setState(() {
                                              userDetails!.followers!.add(
                                                  FirebaseAuth.instance
                                                      .currentUser!.email!);
                                            });
                                          },
                                          icon: const Icon(Icons.person_add),
                                          label: const Text("Follow"))
                                      : OutlinedButton.icon(
                                          onPressed: () async {
                                            await BackEnd.unFollow(
                                                model!.mail!);
                                            setState(() {
                                              userDetails!.followers!.remove(
                                                  FirebaseAuth.instance
                                                      .currentUser!.email!);
                                            });
                                          },
                                          icon: const Icon(Icons.person_off),
                                          label: const Text("Unfollow")),
                                  OutlinedButton.icon(
                                      onPressed: () async {
                                        ChatRoomModel chatRoom =
                                            await BackEnd.getChatRoom(
                                                model!.mail!);
                                        if (context.mounted) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                  chatRoom: chatRoom,
                                                  targetUserMail: model!.mail!,
                                                  targetUser: model!),
                                            ),
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.message_outlined),
                                      label: const Text("Message")),
                                ],
                              )
                            : const SizedBox.shrink(),
                        const Divider(),
                        mutuals != null && mutuals!.isNotEmpty
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width - 20,
                                height: 40,
                                child: ListView.builder(
                                    itemCount: mutuals!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PublicProfile(
                                                        email: mutuals!
                                                            .elementAt(index),
                                                      )));
                                        },
                                        child: Text(
                                            "${mutuals!.elementAt(index)}    "),
                                      );
                                    }))
                            : const SizedBox.shrink(),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CusButton(
                                  keyword: "POST",
                                  value: posts != null ? posts!.length : 0),
                              CusButton(
                                  keyword: "FOLLOWER",
                                  value: userDetails!.followers != null
                                      ? userDetails!.followers!.length
                                      : 0),
                              CusButton(
                                  keyword: "FOLLOWING",
                                  value: userDetails!.following != null
                                      ? userDetails!.following!.length
                                      : 0),
                            ],
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: model!.socialLinks != null &&
                                  model!.socialLinks!.isNotEmpty
                              ? const Text(
                                  "Social Links",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                )
                              : const SizedBox(height: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
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
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: ProfileLink(
                                                  e: e, model: model!)))
                                          .toList()
                                      : [],
                                ),
                              ],
                            ),
                          ),
                        ),
                        model!.achievements != null &&
                                model!.achievements!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //       offset: const Offset(5, 5),
                                  //       blurRadius: 3,
                                  //       color: Colors.grey.shade700),
                                  //   const BoxShadow(
                                  //     blurRadius: 1,
                                  //     color: Colors.white,
                                  //   )
                                  // ]
                                ),
                                child: Column(
                                  children: [
                                    const Text("Archiements or Jobs"),
                                    AchievementCard(
                                      model: model!,
                                      index: 0,
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        OutlinedButton.icon(
                                          icon: const Icon(Icons.show_chart),
                                          onPressed: model!.achievements !=
                                                      null &&
                                                  model!.achievements!.length >
                                                      1
                                              ? () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllAchievements(
                                                                  model:
                                                                      model!)));
                                                }
                                              : null,
                                          label: const Text("view more"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                        model!.achievements != null &&
                                model!.achievements!.isNotEmpty &&
                                model!.skills != null &&
                                model!.skills!.isNotEmpty
                            ? const Divider()
                            : const SizedBox.shrink(),
                        model!.skills != null && model!.skills!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //       offset: const Offset(5, 5),
                                  //       blurRadius: 3,
                                  //       color: Colors.grey.shade700),
                                  //   const BoxShadow(
                                  //     blurRadius: 1,
                                  //     color: Colors.white,
                                  //   )
                                  // ]
                                ),
                                child: Column(
                                  children: [
                                    const Text("Skills"),
                                    SkillCard(
                                      model: model!,
                                      index: 0,
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        OutlinedButton.icon(
                                          icon: const Icon(Icons.show_chart),
                                          onPressed: model!.skills != null &&
                                                  model!.skills!.length > 1
                                              ? () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllSkills(
                                                                  model:
                                                                      model!)));
                                                }
                                              : null,
                                          label: const Text("view more"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  posts != null
                      ? posts!.isNotEmpty
                          ? GridView.builder(
                              padding: const EdgeInsets.all(10),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent:
                                    MediaQuery.of(context).size.width / 3,
                              ),
                              itemCount: posts!.length,
                              itemBuilder: (context, index) {
                                PostModel data =
                                    PostModel.fromMap(posts!.elementAt(index));
                                data.likes ??= [];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PostsFromProfile(
                                          posts: posts!,
                                          currentIndex: index,
                                          profileData: model!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(
                                        left: 2, right: 2, bottom: 4),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(.6)),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${data.imgUrl}"))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.heart_fill,
                                            size: 17,
                                          ),
                                          Text(
                                            "${data.likes!.length}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : SizedBox(
                              child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 200,
                                      child: Lottie.asset(
                                          "assets/lotties/no_posts.json",
                                          fit: BoxFit.cover)),
                                  const Text(
                                    "No Posts",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 40,
                                    ),
                                  )
                                ],
                              ),
                            ))
                      : Center(
                          child: SpinKitCircle(
                            color: Theme.of(context).primaryColor,
                            size: 55,
                          ),
                        ),
                ]
              : const [ProfileShimmer()],
        ),
      ),
    );
  }
}

class AchievementCard extends StatefulWidget {
  const AchievementCard({
    super.key,
    required this.model,
    required this.index,
  });

  final int index;
  final ProfileModel model;

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
        splashColor: Theme.of(context).primaryColor.withOpacity(.5),
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

class SkillCard extends StatefulWidget {
  const SkillCard({
    super.key,
    required this.model,
    required this.index,
  });

  final int index;
  final ProfileModel model;

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        splashColor: Theme.of(context).primaryColor.withOpacity(.5),
        onPressed: () {
          // setState(() {
          //   isExpanded = !isExpanded;
          // });
        },
        child: Container(
          width: 700,
          height: 100,
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
                  "${widget.model.skills!.elementAt(widget.index)['title']} "
                  "(${widget.model.skills!.elementAt(widget.index)['level']})",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  "${widget.model.skills!.elementAt(widget.index)['description']}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
  const ProfileLink({super.key, required this.e, required this.model});

  final Map<String, dynamic> e;
  final ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () async {
            try {
              Uri r = Uri.parse(e['url']);
              await launchUrl(r, mode: LaunchMode.inAppWebView);
            } catch (e) {
              log("$e");
            }
          },
          minWidth: 2,
          splashColor: Theme.of(context).primaryColor.withOpacity(.5),
          child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(.6)),
                  borderRadius: BorderRadius.circular(50)),
              child: SocialMeda.getIcon(e['url'])),
        ),
        Text(e['title'])
      ],
    );
  }
}

class AllAchievements extends StatelessWidget {
  const AllAchievements({super.key, required this.model});

  final ProfileModel model;

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
              child: AchievementCard(index: index, model: model));
        },
      ),
    );
  }
}

class AllSkills extends StatelessWidget {
  const AllSkills({super.key, required this.model});

  final ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skills"),
      ),
      body: ListView.builder(
        itemCount: model.skills!.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SkillCard(index: index, model: model));
        },
      ),
    );
  }
}
