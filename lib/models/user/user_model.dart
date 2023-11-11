import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:zetaton_flutter_task/models/entities/user.dart';

class UserModel with ChangeNotifier {
  User? user;

  UserModel();

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    /// create new firebase user
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      /// save user data to Firestore
      createUser(
        uId: value.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );
    }).catchError((onError) {
      throw onError.toString();
    });
  }

  Future<void> createUser({
    required String uId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    /// create new user instance
    User newUser = User(
      uId: uId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );

    /// add new user data in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(newUser.toMap())
        .catchError((onError) {
      throw onError.toString();
    });
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    /// login with firebase
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      /// get user info
      getUserInfo(uId: value.user!.uid);
    }).catchError((onError) {
      throw onError.toString();
    });
  }

  Future<void> getUserInfo({
    required String uId,
  }) async {
    /// get user info
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      user = User.fromJson(value.data()!);
    }).catchError((onError) {
      throw onError.toString();
    });
  }
}
