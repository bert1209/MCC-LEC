import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mcc_final/Auth/oAuth.dart';
import 'package:mcc_final/Pages/AuthPage.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../Auth/auth.dart';

class ProfileandAboutPage extends StatefulWidget {
  const ProfileandAboutPage({super.key});

  @override
  State<ProfileandAboutPage> createState() => _ProfileandAboutPageState();
}

class _ProfileandAboutPageState extends State<ProfileandAboutPage> {
  final ScrollController _scrollController = ScrollController();

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
      Navigator.pushReplacementNamed(context, '/loginPage');
    } catch (e) {
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              16, 20, 0, 20),
          child: IconButton(
            color: const Color(0xFFEFEFEF),
            onPressed: () {
              Navigator.pushNamed(context, '/homePage');
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Profile & About',
            style: const TextStyle(fontFamily: "poppins", color: Color(0xFFEFEFEF), fontSize: 20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 14, 14, 14),
            child: IconButton(
              onPressed: () {
                // Scroll to the bottom when the info button is clicked
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(Icons.info_outline_rounded, color: Color(0xFFEFEFEF), size: 30),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController, // Attach the controller here
          child: Stack(
            children: [
              // Scrollable Background Image
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.15),

                  Image.network(
                    'https://media.giphy.com/media/CQl0tM5gYyqQg/giphy.gif',
                    height: screenHeight * 1, // Extend the height for scrolling
                    fit: BoxFit.cover,
                  ),

                  Container(
                    width: screenWidth * 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0B0909), Color(0xFF000058)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.05),

                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('About', style: TextStyle(fontSize: 24, color: Color(0xFFEFEFEF), fontWeight: FontWeight.bold, fontFamily: 'gotham')),
                              ),

                              SizedBox(height: screenHeight * 0.015),

                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('Game Box is a community platform for gamers to share, discuss, and explore gaming trends, exchanging insights and experiences about console, PC, and mobile games.', style: TextStyle(fontSize: 16, color: Colors.grey.shade200, fontFamily: 'poppins', height: 1.5)),
                              ),

                              SizedBox(height: screenHeight * 0.04),
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth * 1,
                          color: Color(0xFF00008B),
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.02),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  '"Find the games. Share the journey."',
                                  style: TextStyle(
                                    color: Colors.grey.shade200,
                                    fontFamily: 'poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2
                                  ),
                                  textAlign: TextAlign.center, // Optional for ensuring text alignment
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.01,),

                              Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.03,),

                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Add your action here, e.g., open Facebook
                                        },
                                        child: Container(
                                          height: 33,
                                          width: 33,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEFEFEF),
                                            borderRadius: BorderRadius.circular(45),
                                          ),
                                          child: Icon(
                                            Icons.facebook,
                                            color: Color(0xFF000000),
                                            size: 25,
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: screenWidth * 0.018),

                                      GestureDetector(
                                        onTap: () {
                                          // Add your action here, e.g., open WhatsApp
                                        },
                                        child: Container(
                                          height: 33,
                                          width: 33,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEFEFEF),
                                            borderRadius: BorderRadius.circular(45),
                                          ),
                                          child: Image.asset(
                                            "lib/Assets/Whatsapp.png",
                                            width: 20, // Adjusted to fit within the container
                                            height: 20,
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: screenWidth * 0.018),

                                      GestureDetector(
                                        onTap: () {
                                          // Add your action here, e.g., open Instagram
                                        },
                                        child: Container(
                                          height: 33,
                                          width: 33,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEFEFEF),
                                            borderRadius: BorderRadius.circular(45),
                                          ),
                                          child: Image.asset(
                                            "lib/Assets/instagram.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.015,),
                            ],
                          ),
                        )

                      ],
                    ),
                  )
                ],
              ),

              // Scrollable Foreground Content
              Column(
                children: [
                  Container(
                    height: screenHeight * 0.33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      gradient: LinearGradient(
                        colors: [Color(0xFF000025), Color(0xFF000058)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
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
                              SizedBox(height: screenHeight * 0.025),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: Image.asset(
                                  'lib/Assets/GamepadBlue.png',
                                  height: 65,
                                  width: 65,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.03),

                              AutoSizeText(
                                'Hello, ${snapshot.data}!',
                                style: TextStyle(
                                  fontFamily: "gotham",
                                  fontSize: 25,
                                  color: Colors.grey.shade300,
                                ),
                                maxLines: 1,
                                minFontSize: 25,
                                overflow: TextOverflow.ellipsis,
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
                  // Additional spacing or content
                  SizedBox(height: screenHeight * 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
