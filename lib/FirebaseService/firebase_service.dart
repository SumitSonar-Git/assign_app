import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // // Cloud Functions instance
  // final FirebaseFunctions _functions = FirebaseFunctions.instance;

  // Authentication Methods
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Sign In Error: $e');
      return null;
    }
  }

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Sign Up Error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign Out Error: $e');
    }
  }

  // Firestore Methods
  Future<void> addUserData(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).set(data);
    } catch (e) {
      print('Add User Data Error: $e');
    }
  }

  Future<DocumentSnapshot> getUserData(String userId) async {
    try {
      return await _firestore.collection('users').doc(userId).get();
    } catch (e) {
      print('Get User Data Error: $e');
      rethrow;
    }
  }

  // // Cloud Functions Methods
  // Future<void> callHelloWorldFunction() async {
  //   try {
  //     final HttpsCallable callable = _functions.httpsCallable('helloWorld');
  //     final response = await callable.call();
  //     print('Function Response: ${response.data}');
  //   } catch (e) {
  //     print('Call Function Error: $e');
  //   }
  // }
}
