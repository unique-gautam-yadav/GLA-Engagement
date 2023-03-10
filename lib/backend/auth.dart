import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gla_engage/backend/keywords.dart';
import 'package:gla_engage/backend/models.dart';
import 'package:gla_engage/backend/providers.dart';
import 'package:provider/provider.dart';

final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference studentsRef = store.collection("Users");
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
      await studentsRef.doc(data['mail']).set(data);
      return "ok";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> login(String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      return "ok";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<Map<String, dynamic>?> fetchUserData(String mail) async {
    try {
      DocumentSnapshot<Object?> d =
          await studentsRef.doc(mail.toLowerCase()).get();
      return d.data() as Map<String, dynamic>;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> updateUserData(
      Map<String, dynamic> data, BuildContext? context) async {
    if (context != null) {
      await studentsRef
          .doc(data['mail'])
          .set(StudentModel.fromMap(data).toMap());
      if (data['type'] == KeyWords.studentUser) {
        StudentModel model = StudentModel.fromMap(data);
        await studentsRef.doc(data['mail']).set(model.toMap());
        if (context.mounted) {
          context.read<UserProvider>().setStudent(model);
        }
      } else if (data['type'] == KeyWords.alumniUser) {
        AlumniModel model = AlumniModel.fromMap(data);
        await studentsRef.doc(data['mail']).set(model.toMap());
        if (context.mounted) {
          context.read<UserProvider>().setAlumni(AlumniModel.fromMap(data));
        }
      } else if (data['type'] == KeyWords.teacherUser) {
        TeacherModel model = TeacherModel.fromMap(data);
        await studentsRef.doc(data['mail']).set(model.toMap());
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
    await studentsRef.doc(user.mail).update({
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
    await studentsRef.doc(user.mail).update({
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
    await studentsRef.doc(user.mail).update({
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
    await studentsRef.doc(user.mail).update({
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
}
