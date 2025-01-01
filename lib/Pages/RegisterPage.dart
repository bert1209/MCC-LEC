import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mcc_final/Auth/oAuth.dart';
import 'package:mcc_final/Pages/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Auth/auth.dart';
import '../Function/TeksFunction.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserWithEmailAndPassword() async {
    try {
      // Membuat pengguna baru dengan email dan password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      // Menyimpan username ke Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'username': _controllerUsername.text,
        'email': _controllerEmail.text,
        'uid': userCredential.user?.uid,
      });

      // Navigasi ke halaman login setelah registrasi berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPasswordGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      try {
        // Membuat pengguna baru dengan email dan password
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: account.email,
          password: "      ".toString(),
        );

        // Menyimpan username ke Firestore
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'username': account.displayName,
          'email': account.email,
          'uid': userCredential.user?.uid,
        });

        // Navigasi ke halaman login setelah registrasi berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
      }
    }
  }

  void onRegister() {
    createUserWithEmailAndPassword();
    var navigator = Navigator.of(context);
    navigator.push(
      MaterialPageRoute(
        builder: (builder) {
          return LoginPage();
        },
      ),
    );
  }

  void onRegisterGoogle() {
    createUserWithEmailAndPasswordGoogle();
    var navigator = Navigator.of(context);
    navigator.push(
      MaterialPageRoute(
        builder: (builder) {
          return LoginPage();
        },
      ),
    );
  }

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
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.015,),
                    Align(
                        alignment: Alignment.center,
                        child: Container(

                          width: screenWidth * 0.77,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                  width: screenWidth * 0.5,
                                  child: Text('CREATE YOUR ACCOUNT', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'gotham', fontSize: 25, height: 1.2))
                              ),
                              SizedBox(width: screenWidth * 0.015,),
                              Transform.rotate(
                                angle: 5.9,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Image.asset('lib/Assets/Gamepad.png', height: 85, width: 85,),
                                ),
                              )
                            ],
                          ),
                        )
                    ),

                    SizedBox(height: screenHeight * 0.01),

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
                                'Username',
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
                                  controller: _controllerUsername,
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 16,         // Set font size
                                    color: Colors.grey.shade800,  // Set text color
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Username*',
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
                                    onRegister();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0000BE), // Change the background color
                                    padding: const EdgeInsets.fromLTRB(28, 11, 28, 5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ), // Add padding if needed
                                  ),
                                  child: Text('Register',style: TextStyle(fontSize: 20, fontFamily: 'Gotham', color: Color(0xFFEFEFEF)),),
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
                          onRegisterGoogle();
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
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/loginPage');
                            },
                            child:
                            Text("Sign in Now!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,),)
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
