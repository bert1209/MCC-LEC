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
            style: const TextStyle(fontFamily: 'poppins'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF0000025),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF000025),
        leading: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF00008B),
              borderRadius: BorderRadius.circular(10)),

          margin: const EdgeInsets.fromLTRB(
              16, 20, 0, 20), // Adds 16px space on the left
          child: IconButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pushNamed(context, '/homePage');
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            'My Profile',
            style: const TextStyle(fontFamily: "poppins", color: Colors.white, fontSize: 24),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.network(
                'https://media.giphy.com/media/CQl0tM5gYyqQg/giphy.gif',
                height: double.infinity, // Your desired height
                fit: BoxFit.cover, // Ensures the image covers the entire area without leaving gaps
              ),
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                      gradient: LinearGradient(
                        colors: [Color(0xFF000025), Color(0xFF000058)], // Start and end colors for the gradient
                        begin: Alignment.topCenter, // Start position of the gradient
                        end: Alignment.bottomCenter, // End position of the gradient
                      ),
                    ),
                    alignment: Alignment.center,
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
                            children: [
                              SizedBox(height: screenHeight * 0.015,),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(45)
                                ),
                                child: Image.asset('lib/Assets/GamepadBlue.png', height: 75, width: 75,),
                              ),
                              SizedBox(height: screenHeight * 0.03,),
                              Text(
                                'Hello, ${snapshot.data}!',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: "gotham",
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              SizedBox(
                                width: screenWidth * 0.75,
                                height: screenHeight * 0.065,
                                child: ElevatedButton(
                                  onPressed: () {
                                    signOut(context);
                                    signOutGoogle();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color(0xFF000025),
                                    backgroundColor: const Color(0xFF0000BE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout_rounded,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Sign out",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "gotham",
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 1,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
