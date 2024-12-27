import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcc_final/Pages/AuthPage.dart';
import 'package:mcc_final/Pages/GamePage.dart';
import 'package:mcc_final/Pages/HomePage.dart';
import 'package:mcc_final/Pages/LoginPage.dart';
import 'package:mcc_final/Pages/ProfileandAboutPage.dart';
import 'package:mcc_final/Pages/RegisterPage.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF000025),
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      routes: {
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
        '/homePage': (context) => HomePage(),
        '/aboutProfilePage': (context) => ProfileandAboutPage(),
        // '/gamePage': (context) => GamePage(),
      },
    );
  }
}
