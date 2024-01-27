import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hostelway/models/user_model.dart';

class AuthorizationRepository {
  Future<UserModel?> getUser() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        
        UserModel userModel = UserModel.fromJson(doc.data()!);

        return userModel;
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return null;
  }
}
