import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:glaengage/backend/keywords.dart';
import 'package:glaengage/backend/models.dart';
import 'package:glaengage/backend/providers.dart';
import 'package:provider/provider.dart';

final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference usersRef = store.collection("Users");
final CollectionReference postsRef = store.collection("Posts");

class Auth {
  static Future<String> createUser(
      Map<String, dynamic> data, String password) async {
    try {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: data['mail'] ?? "", password: password);
      } on FirebaseAuthException catch (e) {
        return e.code;
      }
      data['token'] = await FirebaseMessaging.instance.getToken();
      await usersRef.doc(data['mail']).set(data);

      SendEmail() async {
        String username = 'adityachauhan9456923436@gmail.com';
        String password = 'ivxfgoragdskcghn';

        final smtpServer = gmail(username, password);

        final message = Message()
          ..from = Address(username, 'Coding Beasts')
          ..recipients.add(data['mail'])
          ..subject = 'Account Created Successfully'
          ..text =
              ' Welcome To Gla Online Engagement Playtform  .\n\n\n We Hope You will Have a greate time here ,\n\n Thanks.';

        try {
          final sendReport = await send(message, smtpServer);
          print('Message sent: ' + sendReport.toString());
        } on MailerException catch (e) {
          print('Message not sent. + $e');
          for (var p in e.problems) {
            print('Problem: ${p.code}: ${p.msg}');
          }
        }
        var connection = PersistentConnection(smtpServer);
        await connection.send(message);
        await connection.close();
      }

      await SendEmail();

      return "ok";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> login(String mail, String password) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      await usersRef.doc(mail).update({'token': token});
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      return "ok";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static logOut() async {
    await usersRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({'token': "null"});
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> updateUserData(
      Map<String, dynamic> data, BuildContext? context) async {
    if (context != null) {
      await usersRef.doc(data['mail']).set(StudentModel.fromMap(data).toMap());
      if (data['type'] == KeyWords.studentUser) {
        StudentModel model = StudentModel.fromMap(data);
        await usersRef.doc(data['mail']).set(model.toMap());
        if (context.mounted) {
          context.read<UserProvider>().setStudent(model);
        }
      } else if (data['type'] == KeyWords.alumniUser) {
        AlumniModel model = AlumniModel.fromMap(data);
        await usersRef.doc(data['mail']).set(model.toMap());
        if (context.mounted) {
          context.read<UserProvider>().setAlumni(AlumniModel.fromMap(data));
        }
      } else if (data['type'] == KeyWords.teacherUser) {
        TeacherModel model = TeacherModel.fromMap(data);
        await usersRef.doc(data['mail']).set(model.toMap());
        if (context.mounted) {
          context.read<UserProvider>().setTeacher(model);
        }
      }
    }
  }

  static Future<void> addSocialLinkToProfile({
    // required String mail,
    required Map<String, dynamic> data,
    required BuildContext context,
    required ProfileModel user,
  }) async {
    await usersRef.doc(user.mail).update({
      "socialLinks": FieldValue.arrayUnion([data])
    });
    if (user.type == KeyWords.studentUser && context.mounted) {
      StudentModel model = StudentModel.fromMap(user.toMap());
      model.socialLinks ??= [];
      model.socialLinks!.add(data);

      if (context.mounted) {
        context.read<UserProvider>().setStudent(model);
      }
    } else if (user.type == KeyWords.alumniUser && context.mounted) {
      AlumniModel model = AlumniModel.fromMap(user.toMap());
      model.socialLinks ??= [];
      model.socialLinks!.add(data);

      if (context.mounted) {
        context.read<UserProvider>().setAlumni(model);
      }
    } else if (user.type == KeyWords.teacherUser && context.mounted) {
      TeacherModel model = TeacherModel.fromMap(user.toMap());
      model.socialLinks ??= [];
      model.socialLinks!.add(data);

      if (context.mounted) {
        context.read<UserProvider>().setTeacher(model);
      }
    }
  }

  static Future<void> removeSocialLinkToProfile({
    required Map<String, dynamic> data,
    required BuildContext context,
    required ProfileModel user,
  }) async {
    await usersRef.doc(user.mail).update({
      "socialLinks": FieldValue.arrayRemove([data])
    });
    if (user.type == KeyWords.studentUser && context.mounted) {
      StudentModel model = StudentModel.fromMap(user.toMap());
      model.socialLinks ??= [];
      model.socialLinks!.remove(data);

      if (context.mounted) {
        context.read<UserProvider>().setStudent(model);
      }
    } else if (user.type == KeyWords.alumniUser && context.mounted) {
      AlumniModel model = AlumniModel.fromMap(user.toMap());
      model.socialLinks ??= [];
      model.socialLinks!.remove(data);

      if (context.mounted) {
        context.read<UserProvider>().setAlumni(model);
      }
    } else if (user.type == KeyWords.teacherUser && context.mounted) {
      TeacherModel model = TeacherModel.fromMap(user.toMap());
      model.socialLinks ??= [];
      model.socialLinks!.remove(data);

      if (context.mounted) {
        context.read<UserProvider>().setTeacher(model);
      }
    }
  }

  static addAchievement(
      {required Map<String, dynamic> data,
      required BuildContext context,
      required ProfileModel user}) async {
    await usersRef.doc(user.mail).update({
      "achievements": FieldValue.arrayUnion([data])
    });
    if (user.type == KeyWords.studentUser && context.mounted) {
      StudentModel model = StudentModel.fromMap(user.toMap());
      model.achievements ??= [];
      model.achievements!.add(data);

      if (context.mounted) {
        context.read<UserProvider>().setStudent(model);
      }
    } else if (user.type == KeyWords.alumniUser && context.mounted) {
      AlumniModel model = AlumniModel.fromMap(user.toMap());
      model.achievements ??= [];
      model.achievements!.add(data);

      if (context.mounted) {
        context.read<UserProvider>().setAlumni(model);
      }
    } else if (user.type == KeyWords.teacherUser && context.mounted) {
      TeacherModel model = TeacherModel.fromMap(user.toMap());
      model.achievements ??= [];
      model.achievements!.add(data);

      if (context.mounted) {
        context.read<UserProvider>().setTeacher(model);
      }
    }
  }

  static removeAchievement(
      {required Map<String, dynamic> data,
      required BuildContext context,
      required ProfileModel user}) async {
    await usersRef.doc(user.mail).update({
      "achievements": FieldValue.arrayRemove([data])
    });
    if (user.type == KeyWords.studentUser && context.mounted) {
      StudentModel model = StudentModel.fromMap(user.toMap());
      model.achievements ??= [];
      model.achievements!.remove(data);

      if (context.mounted) {
        context.read<UserProvider>().setStudent(model);
      }
    } else if (user.type == KeyWords.alumniUser && context.mounted) {
      AlumniModel model = AlumniModel.fromMap(user.toMap());
      model.achievements ??= [];
      model.achievements!.remove(data);

      if (context.mounted) {
        context.read<UserProvider>().setAlumni(model);
      }
    } else if (user.type == KeyWords.teacherUser && context.mounted) {
      TeacherModel model = TeacherModel.fromMap(user.toMap());
      model.achievements ??= [];
      model.achievements!.remove(data);

      if (context.mounted) {
        context.read<UserProvider>().setTeacher(model);
      }
    }
  }

  static addSkill(
      {required Map<String, dynamic> data,
      required BuildContext context,
      required ProfileModel user}) async {
    await usersRef.doc(user.mail).update({
      "skills": FieldValue.arrayUnion([data])
    });
    await usersRef.doc(FirebaseAuth.instance.currentUser!.email!).update({
      'keywords':
          FieldValue.arrayUnion([data['title'].toString().toUpperCase()])
    });
    if (user.type == KeyWords.studentUser && context.mounted) {
      StudentModel model = StudentModel.fromMap(user.toMap());
      model.skills ??= [];
      model.skills!.add(data);

      if (context.mounted) {
        context.read<UserProvider>().setStudent(model);
      }
    } else if (user.type == KeyWords.alumniUser && context.mounted) {
      AlumniModel model = AlumniModel.fromMap(user.toMap());
      model.skills ??= [];
      model.skills!.add(data);

      if (context.mounted) {
        context.read<UserProvider>().setAlumni(model);
      }
    } else if (user.type == KeyWords.teacherUser && context.mounted) {
      TeacherModel model = TeacherModel.fromMap(user.toMap());
      model.skills ??= [];
      model.skills!.add(data);

      if (context.mounted) {
        context.read<UserProvider>().setTeacher(model);
      }
    }
  }

  static removeSkill(
      {required Map<String, dynamic> data,
      required BuildContext context,
      required ProfileModel user}) async {
    await usersRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "keywords":
          FieldValue.arrayRemove([data['title'].toString().toUpperCase()])
    });
    await usersRef.doc(user.mail).update({
      "skills": FieldValue.arrayRemove([data])
    });
    if (user.type == KeyWords.studentUser && context.mounted) {
      StudentModel model = StudentModel.fromMap(user.toMap());
      model.skills ??= [];
      model.skills!.remove(data);

      if (context.mounted) {
        context.read<UserProvider>().setStudent(model);
      }
    } else if (user.type == KeyWords.alumniUser && context.mounted) {
      AlumniModel model = AlumniModel.fromMap(user.toMap());
      model.skills ??= [];
      model.skills!.remove(data);

      if (context.mounted) {
        context.read<UserProvider>().setAlumni(model);
      }
    } else if (user.type == KeyWords.teacherUser && context.mounted) {
      TeacherModel model = TeacherModel.fromMap(user.toMap());
      model.skills ??= [];
      model.skills!.remove(data);

      if (context.mounted) {
        context.read<UserProvider>().setTeacher(model);
      }
    }
  }

  static Future<String> uploadPost(String caption) async {
    String pId = postsRef.doc().id;
    await postsRef.doc(pId).set(PostModel(
          caption: caption,
          postID: pId,
          postedBy: FirebaseAuth.instance.currentUser!.email,
          timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
        ).toMap());
    return pId;
  }

  static putFileToPost(String pId, String url) async {
    await postsRef.doc(pId).update({'imgUrl': url});
  }

  static Future<List<Map<String, dynamic>>> getAllPostsByMail(
      String mail) async {
    try {
      QuerySnapshot<Object?> data = await postsRef
          .orderBy('timeStamp', descending: true)
          .where('postedBy', isEqualTo: mail)
          .get();

      return List.generate(data.docs.length,
          (index) => data.docs.elementAt(index).data() as Map<String, dynamic>);
    } catch (e) {
      log("$e");
      return [{}];
    }
  }

  static Future<ProfileModel?> getProfileByMail(String email) async {
    DocumentSnapshot<Object?> data = await usersRef.doc(email).get();
    if (data.data() != null) {
      return ProfileModel.fromMap(data.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  likePost(String postID) async {
    await postsRef.doc(postID).update({
      'likes':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.email!])
    });
  }

   unLikePost(String postID) async {
    await postsRef.doc(postID).update({
      'likes':
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.email!])
    });
  }

  static Future<List<ProfileModel>> searchUser(String keyword) async {
    QuerySnapshot<Object?> res = await usersRef
        .where("mail", isGreaterThanOrEqualTo: keyword)
        // .where('name', isGreaterThanOrEqualTo: keyword)
        .get();
    List<ProfileModel> data = [];
    for (var e in res.docs) {
      ProfileModel form =
          ProfileModel.fromMap(e.data() as Map<String, dynamic>);
      if (form.mail!.startsWith(keyword, 0) &&
          form.mail != FirebaseAuth.instance.currentUser!.email) {
        data.add(form);
      }
    }
    QuerySnapshot<Object?> res2 =
        await usersRef.where("name", isGreaterThanOrEqualTo: keyword).get();
    for (var e in res2.docs) {
      ProfileModel temp =
          ProfileModel.fromMap(e.data() as Map<String, dynamic>);
      if (temp.name!.startsWith(keyword, 0) &&
          temp.mail != FirebaseAuth.instance.currentUser!.email) {
        if (data.contains(temp)) {
        } else {
          data.add(temp);
        }
      }
    }
    return data;
  }

  static Future<List<ProfileModel>> suggestion(String keyword) async {
    QuerySnapshot<Object?> res = await usersRef
        .where("branch", isEqualTo: keyword)
        // .where('name', isGreaterThanOrEqualTo: keyword)
        .get();
    List<ProfileModel> data = [];
    for (var e in res.docs) {
      ProfileModel form =
          ProfileModel.fromMap(e.data() as Map<String, dynamic>);
      // if (form.mail!.startsWith(keyword, 0) &&
      //     form.mail != FirebaseAuth.instance.currentUser!.email) {
      data.add(form);
      // }
    }
    return data;
  }
}
