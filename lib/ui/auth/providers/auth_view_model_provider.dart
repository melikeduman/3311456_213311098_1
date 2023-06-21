import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final authViewModelProvider = ChangeNotifierProvider(
  (ref) => AuthViewModel(),
);

class AuthViewModel extends ChangeNotifier {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  User? get user => _auth.currentUser;

  String _email = '';
  String get email => _email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  bool _gizliPassword = true;
  bool get gizliPassword => _gizliPassword;
  set gizliPassword(bool gizliPassword) {
    _gizliPassword = gizliPassword;
    notifyListeners();
  }
  bool _gizliPassword2 = true;
  bool get gizliPassword2 => _gizliPassword2;
  set gizliPassword2(bool gizliPassword2) {
    _gizliPassword2 = gizliPassword2;
    notifyListeners();
  }

  String _password2 = '';
  String get password2 => _password2;
  set password2(String password2) {
    _password2 = password2;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
  File? _file;
  File? get file => _file;
  set file(File? file) {
    _file = file;
    notifyListeners();
  }

  String? emailKontrol(String value) {
    const String format =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    return !RegExp(format).hasMatch(value) ? "Geçerli bir mail giriniz" : null;
  }



  Future<void> giris() async {
    loading = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _loading=false;
    } on FirebaseAuthException catch (e) {
      loading=false;
      if (e.code == "wrong-password") {
        return Future.error("Yanlış Şifre");
      } else if (e.code == "user-not-found") {
        return Future.error("Kullanıcı bulunamadı!");
      }
      else {
        return Future.error(e.message ?? "");
      }
    } catch(e){
      loading=false;
      if (kDebugMode) {
        print(e);
      }
    }

  }



  Future<void> kayit() async {
    loading = true;
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _loading=false;
      try {
        if (result != null) {
          await firebaseFirestore
              .collection('users')
              .doc(_auth.currentUser?.uid)
              .set({
            "user_id": _auth.currentUser?.uid,
            "user_email": email,
            "user_password": password,
          });

        }
      }catch (e) {
        print("$e");
      }
    } on FirebaseAuthException catch (e) {
      loading=false;
      if (e.code == "weak-password") {
        return Future.error("Zayıf Parola!");
      } else {
        return Future.error(e.message ?? "");
      }
    } catch(e){
      loading=false;
      if (kDebugMode) {
        print(e);
      }
    }
  }


  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }

}
