import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mcc_final/Pages/LoginPage.dart';

import '../Auth/auth.dart';
import '../Function/TeksFunction.dart';

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

  Future<void> signInWithEmailAndPassword() async {
    try {
      await auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
    print(_controllerEmail);
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
                    auth().createUserWithEmailAndPassword(
                        email: _controllerEmail.text,
                        password: _controllerPassword.text);
                    var navigator = Navigator.of(context);
                    navigator.push(
                      MaterialPageRoute(
                        builder: (builder) {
                          return LoginPage();
                        },
                      ),
                    );
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