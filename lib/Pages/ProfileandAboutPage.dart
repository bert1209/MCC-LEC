import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mcc_final/Auth/oAuth.dart';
import 'package:mcc_final/Pages/AuthPage.dart';

import '../Auth/auth.dart';

class ProfileandAboutPage extends StatefulWidget {
  const ProfileandAboutPage({super.key});

  @override
  State<ProfileandAboutPage> createState() => _ProfileandAboutPageState();
}

class _ProfileandAboutPageState extends State<ProfileandAboutPage> {
  Future<String?> fetchUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc['username'] as String?;
    }
    return null;
  }

  Future<void> signOut(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.signOut();
      // Navigasi ke halaman login setelah berhasil sign out
      Navigator.pushReplacementNamed(context, '/loginPage');
    } catch (e) {
      // Tampilkan pesan error jika terjadi kesalahan saat sign out
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error during sign out: $e',
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0000025),
      appBar: AppBar(
        backgroundColor: Color(0xFF000025),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/homePage');
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: fetchUsername(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error fetching username');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text('No username found');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello, ${snapshot.data}!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: "Gotham",
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        // auth().signOut();
                        signOut(context);
                        signOutGoogle();
                        // Navigator.pushNamed(context, "/loginPage");
                      },
                      child: const Text(
                        "Sign Out",
                        style: TextStyle(
                          fontFamily: "Gotham",
                        ),
                      ))
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
