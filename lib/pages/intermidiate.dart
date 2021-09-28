import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waco_mobile/pages/feed.dart';

class Intermidiate extends StatelessWidget {
  const Intermidiate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamed(context, 'home');
      } else {
        debugPrint('User is signed in!');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Feed(uid: user.uid)));
      }
    });
    return const Center(child: CircularProgressIndicator());
  }
}
