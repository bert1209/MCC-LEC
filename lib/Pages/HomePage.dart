import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Auth/auth.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = auth().currentUser;

  Future<void> signOut() async {
    await auth().signOut();
  }

  // Widget _title() {
  //   return const Text('Firebase Auth');
  // }

  //  Widget _UserID() {
  //   return Text(user?.email ?? "User Email");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(user?.email ?? "User Email"),
        ],
      ),
    );
  }
}
