import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; 

  AuthRepository({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password, String name, String phone, String country) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    if (user != null) {
      await saveUserData(user.uid, name, phone, country);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> getMessagingToken() async {
    return await _firebaseMessaging.getToken() ?? 'No Token'; 
  }

  Future<void> saveUserData(String userId, String name, String phone, String country) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': name,
      'phone': phone,
      'country': country,
    });
  }
}

abstract class IAuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(String email, String password, String name, String phone, String country);
  Future<void> signOut();
  Future<String> getMessagingToken();
}