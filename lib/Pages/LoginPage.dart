import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    try {
      await auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
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
                height: 150,
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
                    auth().signInWithEmailAndPassword(
                      email: _controllerEmail.text,
                      password: _controllerPassword.text,
                    );
                    var navigator = Navigator.of(context);
                    navigator.push(
                      MaterialPageRoute(
                        builder: (builder) {
                          return HomePage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Sign In",
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
                  onPressed: () {},
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
                        "Sign In With Google",
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
                    "Didn't have an account?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButtons(
                    Texts: "Register Now!",
                    TextSize: 15,
                    onPress: () {
                      Navigator.pushNamed(context, '/registerPage');
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
