import 'dart:convert';
import 'dart:developer';
import 'dart:math' show Random;

import 'package:flutter/Material.dart';
import 'package:glaengage/backend/providers.dart';
import 'package:glaengage/root/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glaengage/backend/models.dart';

import 'auth.dart';

final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference chatRoomRef = store.collection("chatrooms");
final CollectionReference userDetailsRef = store.collection("userDetails");
final CollectionReference postsRef = store.collection("Posts");

class BackEnd {
  static Future<ChatRoomModel> getChatRoom(String targetUserMail) async {
    QuerySnapshot<Object?> d = await chatRoomRef
        .where('participants.${targetUserMail.hashCode}', isEqualTo: true)
        .where(
            "participants.${FirebaseAuth.instance.currentUser!.email!.hashCode}",
            isEqualTo: true)
        .get();
    log("${d.docs.length}");
    if (d.docs.isNotEmpty) {
      return ChatRoomModel.fromMap(d.docs.first.data() as Map<String, dynamic>);
    } else {
      ChatRoomModel model =
          ChatRoomModel(chatroomid: const Uuid().v1(), participants: {
        FirebaseAuth.instance.currentUser!.email!.hashCode.toString(): true,
        targetUserMail.hashCode.toString(): true
      }, users: [
        FirebaseAuth.instance.currentUser!.email!,
        targetUserMail,
      ]);
      await chatRoomRef.doc(model.chatroomid).set(model.toMap());
      return model;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getChats(String roomID) {
    return chatRoomRef
        .doc(roomID)
        .collection("chats")
        .orderBy("timeStamp", descending: true)
        .snapshots();
  }

  static sendChat(String roomID, ChatModel chat) async {
    await chatRoomRef.doc(roomID).update({
      'lastActive': "${DateTime.now().millisecondsSinceEpoch}",
      'lastmessage': chat.message
    });
    await chatRoomRef
        .doc(roomID)
        .collection("chats")
        .doc(const Uuid().v1())
        .set(chat.toMap());
  }

  static follow(String userMail) async {
    await userDetailsRef.doc(userMail).update({
      "followers":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.email])
    });
  }

  static unFollow(String userMail) async {
    await userDetailsRef.doc(userMail).update({
      "followers":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.email])
    });
  }

  static Future<UserDetails> getUserDetial(String userMail) async {
    log("sdfsd");
    UserDetails model = UserDetails();
    DocumentSnapshot<Object?> data = await userDetailsRef.doc(userMail).get();
    if (data.data() == null) {
      userDetailsRef.doc(userMail).set({"mail": userMail});
      return UserDetails();
    }
    model = UserDetails.fromMap(data.data() as Map<String, dynamic>);
    model.following ??= [];
    QuerySnapshot<Object?> data2 =
        await userDetailsRef.where("followers", arrayContains: userMail).get();
    log("${data2.docs.length}  $userMail");
    for (var e in data2.docs) {
      model.following!.add(e.get("mail"));
    }
    return model;
  }

  static Future<List<HomePagePosts>> getPosts() async {
    QuerySnapshot<Object?> data =
        await postsRef.orderBy("timeStamp", descending: true).get();

    List<HomePagePosts> res = [];

    for (var e in data.docs) {
      PostModel d = PostModel.fromMap(e.data() as Map<String, dynamic>);
      // if (d.postedBy != FirebaseAuth.instance.currentUser!.email!) {
      ProfileModel? p = await Auth.getProfileByMail(d.postedBy!);
      res.add(HomePagePosts(post: d, profile: p));
      // }
    }
    return res;
  }

  static Future<List<HomePagePosts>> getSuggestedPosts(
      BuildContext context) async {
    List<HomePagePosts> ps = [];
    List<String>? keywords =
        Provider.of<UserProvider>(context, listen: false).getProfile!.keywords;
    List<ProfileModel>? accounts = await getSuggestedAccounts(context);
    keywords ??= [];
    accounts ??= [];
    for (var e in accounts) {
      QuerySnapshot<Object?> d = await postsRef
          .where('field',
              arrayContains:
                  keywords.elementAt(Random().nextInt(keywords.length)))
          .where('postedBy', isEqualTo: e.mail)
          .orderBy('timeStamp', descending: true)
          .get();
      for (var e2 in d.docs) {
        ps.add(HomePagePosts(
            post: PostModel.fromMap(e2.data() as Map<String, dynamic>),
            profile: e));
      }
    }
    return ps;
  }

  static Future<List<HomePagePosts>> getRandomPosts() async {
    List<HomePagePosts> posts = [];

    QuerySnapshot<Object?> d = await postsRef.get();

    for (var e in d.docs) {
      PostModel post = PostModel.fromMap(e.data() as Map<String, dynamic>);
      DocumentSnapshot<Object?> t = await usersRef.doc(post.postedBy).get();
      if (t.data() != null) {
        posts.add(HomePagePosts(
            post: post,
            profile: ProfileModel.fromMap(t.data() as Map<String, dynamic>)));
      }
    }
    posts.shuffle();
    return posts;
  }

  static Future<List<ProfileModel>?> getSuggestedAccounts(
      BuildContext context) async {
    List<String>? skills =
        Provider.of<UserProvider>(context, listen: false).getProfile!.keywords;
    List<ProfileModel>? data;
    data = [];
    skills ??= [];
    if (skills.isNotEmpty) {
      for (var e in skills) {
        QuerySnapshot<Object?> d = await usersRef
            .where('keywords', arrayContains: e.toString().toUpperCase())
            .limit(5)
            .get();
        for (var e in d.docs) {
          data.add(ProfileModel.fromMap(e.data() as Map<String, dynamic>));
        }
      }
    }
    data.shuffle();
    return data;
  }

  static Future<List<ProfileModel>?> getSuggestedAccounts2(
      BuildContext context) async {
    List<String>? skills =
        Provider.of<UserProvider>(context, listen: false).getProfile!.keywords;
    List<ProfileModel>? data;
    data = [];
    skills ??= [];
    if (skills.isNotEmpty) {
      for (var e in skills) {
        QuerySnapshot<Object?> d = await usersRef
            .where('keywords', arrayContains: e.toString().toUpperCase())
            .limit(5)
            .get();
        for (var e in d.docs) {
          data.add(ProfileModel.fromMap(e.data() as Map<String, dynamic>));
        }
      }
    }
    if (data.length < 5) {
      QuerySnapshot<Object?> te = await usersRef
          // .where('branch',
          //     isEqualTo:
          //         '${Provider.of<UserProvider>(context, listen: false).getProfile!.branch}')
          .limit(15)
          .get();
      for (var ee in te.docs) {
        data.add(ProfileModel.fromMap(ee.data() as Map<String, dynamic>));
      }
    }
    data.shuffle();
    return data;
  }

  static Future<List<HomePagePosts>> getFollowersPost() async {
    List<HomePagePosts> posts = [];

    UserDetails details =
        await getUserDetial(FirebaseAuth.instance.currentUser!.email!);
    details.following ??= [];
    for (var e in details.following!) {
      DocumentSnapshot<Object?> f = await usersRef.doc(e).get();
      ProfileModel profile =
          ProfileModel.fromMap(f.data() as Map<String, dynamic>);
      var today = DateTime.now().subtract(const Duration(days: 1));
      QuerySnapshot<Object?> temp = await postsRef
          .where('postedBy', isEqualTo: profile.mail)
          .where('timeStamp',
              isGreaterThanOrEqualTo: "${today.millisecondsSinceEpoch}")
          .get();
      for (var en in temp.docs) {
        posts.add(HomePagePosts(
            post: PostModel.fromMap(en.data() as Map<String, dynamic>),
            profile: profile));
      }
    }

    return posts;
  }

  static Future<List<String>> getMutualUser(UserDetails destUser) async {
    List<String> users = [];
    destUser.followers ??= [];
    UserDetails temp =
        await getUserDetial(FirebaseAuth.instance.currentUser!.email!);
    temp.followers ?? [];
    for (var e in temp.followers!) {
      for (var e2 in destUser.followers!) {
        if (e == e2) {
          users.add(e);
        }
      }
    }
    return users;
  }

  static Future<List<ChatRoomModel>> getRecentChat() async {
    List<ChatRoomModel> model = [];

    QuerySnapshot<Object?> temp = await chatRoomRef
        .where('users',
            arrayContains: FirebaseAuth.instance.currentUser!.email!)
        .orderBy('lastActive', descending: true)
        .get();

    for (var e1 in temp.docs) {
      log("aslkdf");
      model.add(ChatRoomModel.fromMap(e1.data() as Map<String, dynamic>));
    }
    return model;
  }
}
