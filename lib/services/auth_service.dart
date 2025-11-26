// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> registerAdmin({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String profession,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = cred.user;
      if (user == null) return null;

      UserModel newUser = UserModel(
        uid: user.uid,
        fullName: fullName,
        email: email,
        phone: phone,
        profession: profession,
        photoUrl: '', // On ajoutera les photos plus tard
        role: 'admin',
      );

      await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
      return newUser;
    } catch (e) {
      print("Erreur inscription: $e");
      return null;
    }
  }

  Future<UserModel?> login(
      {required String email, required String password}) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (cred.user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(cred.user!.uid).get();
        if (userDoc.exists) {
          return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        }
      }
      return null;
    } catch (e) {
      print("Erreur connexion: $e");
      return null;
    }
  }

  Stream<UserModel?> get currentUser {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user.uid).get();
      return doc.exists
          ? UserModel.fromMap(doc.data() as Map<String, dynamic>)
          : null;
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
