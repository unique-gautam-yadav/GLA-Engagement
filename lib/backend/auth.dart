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
      await studentsRef.doc(data['mail']).set(Student.fromMap(data).toMap());
      if (data['type'] == KeyWords.studentUser) {
        Student model = Student.fromMap(data);
        await studentsRef.doc(data['mail']).set(model.toMap());
        if (context.mounted) {
          context.read<UserProvider>().setStudent(model);
        }
      } else if (data['type'] == KeyWords.alumniUser) {
        Alumni model = Alumni.fromMap(data);
        await studentsRef.doc(data['mail']).set(model.toMap());
        if (context.mounted) {
          context.read<UserProvider>().setAlumni(Alumni.fromMap(data));
        }
      } else if (data['type' == KeyWords.teacherUser]) {
        Teacher model = Teacher.fromMap(data);
        await studentsRef.doc(data['mail']).set(model.toMap());
        if (context.mounted) {
          context.read<UserProvider>().setTeacher(model);
        }
      }
    }
  }
}
