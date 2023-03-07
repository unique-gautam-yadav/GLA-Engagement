import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
        // log(e.code);
        return e.code;
      }
      await studentsRef.doc(data['mail']).set(data);
      return "ok";
    } catch (e) {
      // log(e.toString());
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
}
