import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waco_mobile/pages/feed.dart';

class Intermidiate extends StatelessWidget {
  final bool subscribe;
  const Intermidiate({Key? key, this.subscribe = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (subscribe) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushNamed(context, 'home');
        } else {
          debugPrint('User is signed in!');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Feed(uid: user.uid, email: user.email),
            ),
          );
        }
      });
    }
    return const Center(child: CircularProgressIndicator());
  }
}
