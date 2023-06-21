import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth =FirebaseAuth.instance;

  User? get user => _auth.currentUser;



  Future<void> writeItem(UserModel user, {File? file}) async {
    final ref = _firestore
        .collection("users")
        .doc(_auth.currentUser?.uid);
    String? imageUrl = file != null
        ? (await (await _storage.ref("images").child(ref.id).putFile(file))
        .ref
        .getDownloadURL())
        : null;
    await
    ref.set(user.copyWith(
        image: imageUrl
    ).toMap(), SetOptions(merge: true));
  }
  Stream<List<UserModel>> get itemsStream =>_firestore
      .collection('users')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(
        (event) => event.docs.map((e)=>UserModel.fromFirestore(e)).toList(),
  );

  Stream<DocumentSnapshot> getUserById(String userId) {
    return _firestore.collection('users').doc(_auth.currentUser?.uid).snapshots();
  }


  void delete(String id){
    _firestore.collection("users").doc(id).delete();
  }


}
