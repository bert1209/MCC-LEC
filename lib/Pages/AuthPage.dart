import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mcc_final/Pages/LoginPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp().whenComplete(() {
      print("aa");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body:
      SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: screenHeight * 0.7,
                    width: double.infinity, // To make it fill the width of the screen
                    child: Image.asset(
                      'lib/Assets/header.jpg',
                      fit: BoxFit.cover, // Adjusts how the image fits in the container
                    ),
                  ),



                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight * 0.33,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFF000025),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(1), // Shadow color
                          blurRadius: 10, // Blur amount
                          spreadRadius: 2, // Spread amount
                          offset: Offset(4, 4),
                        )
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.75,
                        height: screenHeight * 0.065,
                        child: ElevatedButton(
                          onPressed: () {
                            // var navigator = Navigator.of(context);
                            // navigator.push(
                            //   MaterialPageRoute(
                            //     builder: (builder) {
                            //       return LoginPage();
                            //     },
                            //   ),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF000025),
                            backgroundColor: const Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "gotham",
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025,),

                      SizedBox(
                        width: screenWidth * 0.75,
                        height: screenHeight * 0.065,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/registerPage');
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF000025),
                            backgroundColor: const Color(0xFF00008B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "gotham",
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Column(
                children: [
                  SizedBox(height: screenHeight * 0.045,),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(45)
                        ),
                        child: Image.asset('lib/Assets/GamepadBlue.png', height: 55, width: 55,),
                      )
                  ),

                  SizedBox(height: screenHeight * 0.01,),

                  Text(
                    'Game Box',
                    style: TextStyle(
                      fontFamily: 'gotham',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
