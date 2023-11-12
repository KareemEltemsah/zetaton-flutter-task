import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:zetaton_flutter_task/common/cache_helper.dart';
import 'package:zetaton_flutter_task/models/entities/user.dart';

class UserModel with ChangeNotifier {
  User? user;

  UserModel() {
    getLocalUser();
  }

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
        .then((value) async {
      /// save user data to Firestore
      await saveUserInfoToFirestore(
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

  Future<void> saveUserInfoToFirestore({
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
        .then((value) async {
      /// get user info
      await getUserInfo(uId: value.user!.uid);
    }).catchError((onError) {
      throw onError.toString();
    });
  }

  Future<void> getUserInfo({
    required String uId,
  }) async {
    /// get user info from Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      user = User.fromJson(value.data()!);
      /// notify listeners to show home screen
      notifyListeners();

      /// save user data
      saveUserInfo();
    }).catchError((onError) {
      throw onError.toString();
    });
  }

  saveUserInfo() async {
    /// locally save user data
    await CacheHelper.saveData(
      key: 'user_data',
      value: jsonEncode(user!.toMap()),
    );
  }

  logout() async {
    /// logout and remove user data
    user = null;
    await CacheHelper.removeData(key: 'user_data');
    /// notify listeners to show login screen
    notifyListeners();
  }

  getLocalUser() {
    /// check if there is user data saved locally
    var userInfo = CacheHelper.getData(key: 'user_data');
    if (userInfo == null) return;

    /// assign saved data to current user
    user = User.fromJson(jsonDecode(userInfo));
    /// notify listeners to show home screen
    notifyListeners();
  }
}
