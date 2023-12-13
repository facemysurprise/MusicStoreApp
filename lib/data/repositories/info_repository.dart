import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  final DatabaseReference _usersRef = FirebaseDatabase.instance.ref("users");

  Future<void> createUser(String uid, Map<String, dynamic> userData) async {
    await _usersRef.child(uid).set(userData);
  }
}