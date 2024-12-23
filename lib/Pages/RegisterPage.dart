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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF0000025),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 70),
              Text(
                "Game Box",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFFFFFFF),
                  fontFamily: "Gotham",
                ),
              ),
              SizedBox(
                height: 110,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _controllerUsername,
                  style: const TextStyle(fontFamily: "Gotham", fontSize: 15),
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF777777),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF333333),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: const Color(0xFFFFFFFF),
                    filled: true,
                    hintText: "Username",
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _controllerEmail,
                  style: const TextStyle(fontFamily: "Gotham", fontSize: 15),
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF777777),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF333333),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: const Color(0xFFFFFFFF),
                    filled: true,
                    hintText: "Email",
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _controllerPassword,
                  style: const TextStyle(fontFamily: "Gotham", fontSize: 15),
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF777777),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF333333),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: const Color(0xFFFFFFFF),
                    filled: true,
                    hintText: "Password",
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(height: 45),
              SizedBox(
                width: 335,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // createUserWithEmailAndPassword();
                    // var navigator = Navigator.of(context);
                    // navigator.push(
                    //   MaterialPageRoute(
                    //     builder: (builder) {
                    //       return LoginPage();
                    //     },
                    //   ),
                    // );
                    // onRegister();
                    createUserWithEmailAndPassword();
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontFamily: "Poppin",
                      fontSize: 20,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF000025),
                    backgroundColor: const Color(0xFF00008B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Image.asset(
                "lib/Assets/or.png",
                width: 350,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 325,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // googleSignIn();
                    // signInGoogles(context);
                    // signOutGoogle();
                    // signInGoogle();
                    onRegisterGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF000025),
                    backgroundColor: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const SizedBox(width: 100),
                      SizedBox(
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFFFFFFFF),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Image.asset(
                              "lib/Assets/googles.png",
                              height: 37,
                              width: 37,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Sign Up With Google",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SemiPoppins",
                          //fontWeight: FontWeight.bold,
                          color: Color(0xFF000025),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButtons(
                    Texts: "Sign in now!",
                    TextSize: 15,
                    onPress: () {
                      Navigator.pushNamed(context, '/loginPage');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
