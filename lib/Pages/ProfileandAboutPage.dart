import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mcc_final/Auth/oAuth.dart';
import 'package:mcc_final/Pages/AuthPage.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProfileandAboutPage extends StatefulWidget {
  const ProfileandAboutPage({super.key});

  @override
  State<ProfileandAboutPage> createState() => _ProfileandAboutPageState();
}

class _ProfileandAboutPageState extends State<ProfileandAboutPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isInfoButton = true; // Track the button state (true = info, false = person)

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

  void _toggleScroll() {
    if (_isInfoButton) {
      // Scroll to the bottom
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      );
    } else {
      // Scroll to the top
      _scrollController.animateTo(
        0.0,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      );
    }
    // Toggle the button state
    setState(() {
      _isInfoButton = !_isInfoButton;
    });
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
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.fromLTRB(16, 20, 0, 20),
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
          child: const Text(
            'My Profile',
            style: TextStyle(
                fontFamily: "poppins", color: Color(0xFFEFEFEF), fontSize: 20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 14, 14, 14),
            child: IconButton(
              onPressed: _toggleScroll, // Call the toggle scroll function
              icon: Icon(
                _isInfoButton ? Icons.info_outline_rounded : Icons.person,
                color: const Color(0xFFEFEFEF),
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.15),
                  Image.network(
                    'https://media.giphy.com/media/CQl0tM5gYyqQg/giphy.gif',
                    height: screenHeight * 1,
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
                          padding: const EdgeInsets.only(left: 16.0, right:  16.0),
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.035),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('About',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Color(0xFFEFEFEF),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'gotham')),
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Game Box is a community platform for gamers to share, discuss, and explore gaming trends, exchanging insights and experiences about console, PC, and mobile games.',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade200,
                                      fontFamily: 'poppins',
                                      height: 1.5
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Want to know more?",
                              style: TextStyle(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/aboutPage');
                                },
                                child:
                                Text("Click here!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,),)
                            )
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.03,),



                      ],
                    ),
                  ),
                ],
              ),
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
