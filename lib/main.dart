import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcc_final/Pages/AuthPage.dart';

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
        scaffoldBackgroundColor: const Color(0xFF777777),
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      routes: {},
    );
  }
}
