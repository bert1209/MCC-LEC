import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mendapatkan pengguna saat ini
  User? get currentUser => _firebaseAuth.currentUser;

  // Mendapatkan perubahan status autentikasi
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Membuat akun baru dengan email, password, dan username
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      // Membuat akun pengguna di Firebase Authentication
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Simpan data tambahan (email dan username) ke Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('User created and data saved in Firestore');
    } catch (e) {
      print('Error during account creation: $e');
      rethrow; // Biarkan error dilempar ke UI jika diperlukan
    }
  }

  // Login dengan email dan password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signed in successfully');
    } catch (e) {
      print('Error during sign-in: $e');
      rethrow;
    }
  }

  // Mendapatkan username berdasarkan UID pengguna saat ini
  Future<String?> getUsername() async {
    try {
      String uid = _firebaseAuth.currentUser!.uid; // Dapatkan UID pengguna
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        return userDoc['username'] as String?;
      } else {
        print('No document found for user');
        return null;
      }
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }

  // Mendapatkan username berdasarkan email
  Future<String?> getUsernameByEmail(String email) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (query.docs.isNotEmpty) {
        return query.docs.first['username'] as String?;
      } else {
        print('No user found with this email');
        return null;
      }
    } catch (e) {
      print('Error fetching username by email: $e');
      return null;
    }
  }

  // Keluar dari akun
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      print('User signed out successfully');
    } catch (e) {
      print('Error during sign-out: $e');
    }
  }
}
