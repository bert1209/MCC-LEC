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
    return Scaffold(
      backgroundColor: const Color(0xFF000025),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Game Box",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFFFFFFF),
                  fontFamily: "Gotham",
                ),
              ),
              const SizedBox(height: 70),
              Image.asset(
                "lib/Assets/Gamepad.png",
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: 70,
              ),
              SizedBox(
                width: 335,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
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
                    "Sign In",
                    style: TextStyle(
                      fontFamily: "Poppin",
                      fontSize: 20,
                      color: const Color(0xFF000025),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF000025),
                    backgroundColor: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 335,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registerPage');
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
            ],
          ),
        ),
      ),
    );
  }
}
