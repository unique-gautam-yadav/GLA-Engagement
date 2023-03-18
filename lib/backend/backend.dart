import 'dart:developer';

import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glaengage/backend/models.dart';

final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference chatRoomRef = store.collection("chatrooms");
final CollectionReference userDetailsRef = store.collection("userDetails");

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
    await chatRoomRef
        .doc(roomID)
        .collection("chats")
        .doc(const Uuid().v1())
        .set(chat.toMap());
  }

  static Future<List<ChatRoomModel>> getRecentChats() async {
    QuerySnapshot<Object?> d = await chatRoomRef
        .where(
            "participants.${FirebaseAuth.instance.currentUser!.email!.hashCode}",
            isEqualTo: true)
        .get();

    return List.generate(
      d.docs.length,
      (index) {
        return ChatRoomModel.fromMap(
            d.docs.elementAt(index).data() as Map<String, dynamic>);
      },
    );
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
}
