import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mcc_final/Function/TeksFunction.dart';
import 'package:mcc_final/Pages/AuthPage.dart';
import 'package:mcc_final/Pages/HomePage.dart';
import '../Auth/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    if (_controllerPassword != "      ") {
      try {
        await auth().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
        Navigator.pushReplacementNamed(context, '/homePage');
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'User with this email does not exist.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else {
          errorMessage = e.message ?? 'Login failed.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        );
      }
    }
  }

  Future<void> signInWithEmailAndPasswordGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    final GoogleSignInAccount? account = await _googleSignIn.signIn();

    if (account != null) {
      try {
        await auth().signInWithEmailAndPassword(
          email: account.email,
          password: "      ".toString(),
        );
        Navigator.pushReplacementNamed(context, '/homePage');
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'User with this email does not exist.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else {
          errorMessage = e.message ?? 'Login failed.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body:
        SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.05,),
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
                    SizedBox(height: screenHeight * 0.035),
                    Align(
                        alignment: Alignment.center,
                        child: Text('Sign in to Game Box', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'gotham', fontSize: 25))
                    ),
                    SizedBox(height: screenHeight * 0.045),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.topLeft,
                          width: screenWidth * 0.8,
                          padding: EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                            color: Color(0xFF000058),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
                            children: [
                              SizedBox(height: screenHeight * 0.05),

                              Text(
                                'Email address',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'gotham',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left, // Explicitly align the text to the left
                              ),

                              SizedBox(height: screenHeight * 0.01), // Add spacing between the text and text field if needed

                              SizedBox(
                                height: 40, // Control the height of the TextField
                                child: TextField(
                                  controller: _controllerEmail,
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 16,         // Set font size
                                    color: Colors.grey.shade800,  // Set text color
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Email*',
                                    hintStyle: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 14,         // Font size for hint text
                                      color: Colors.grey,   // Color for hint text
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFEFEFEF),
                                  ),
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.03,),

                              Text(
                                'Password',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'gotham',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left, // Explicitly align the text to the left
                              ),

                              SizedBox(height: screenHeight * 0.01), // Add spacing between the text and text field if needed

                              SizedBox(
                                height: 40, // Control the height of the TextField
                                child: TextField(
                                  controller: _controllerPassword,
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 16,         // Set font size
                                    color: Colors.grey.shade800,  // Set text color
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Password*',
                                    hintStyle: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 14,         // Font size for hint text
                                      color: Colors.grey,   // Color for hint text
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFEFEFEF),
                                  ),
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.035),

                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    signInWithEmailAndPassword();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0000BE), // Change the background color
                                    padding: const EdgeInsets.fromLTRB(28, 11, 28, 5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ), // Add padding if needed
                                  ),
                                  child: Text('Sign in',style: TextStyle(fontSize: 20, fontFamily: 'Gotham', color: Color(0xFFEFEFEF)),),
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.03),
                            ],
                          ),

                        )
                    ),

                    SizedBox(height: screenHeight * 0.01,),

                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30), // Adjust padding as needed
                        child: Row(
                          children: [
                            // Line before the text
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300, // Line color
                                thickness: 1,        // Line thickness
                              ),
                            ),
                            // The "OR" text
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25), // Space around "OR"
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontFamily: 'gotham',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            // Line after the text
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.005,),

                    SizedBox(
                      width: screenWidth * 0.75,
                      height: screenHeight * 0.065,
                      child: ElevatedButton(
                        onPressed: () {
                          signInWithEmailAndPasswordGoogle();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF000025),
                          backgroundColor: const Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "lib/Assets/googles.png",
                              height: 30,
                              width: 30,
                            ),

                            const SizedBox(width: 10),

                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "gotham",
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't have an account?",
                          style: TextStyle(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/registerPage');
                            },
                            child:
                            Text("Register Now!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,),)
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}
