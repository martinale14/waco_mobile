import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:waco_mobile/providers/user_provider.dart';

class Intermidiate extends StatelessWidget {
  final bool subscribe;
  const Intermidiate({Key? key, this.subscribe = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProv = Provider.of(context, listen: false);
    if (subscribe) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          userProv.uid = '';
          userProv.email = '';
          Navigator.pushNamed(context, 'home');
        } else {
          userProv.uid = user.uid;
          userProv.email = user.email!;
          Navigator.pushNamed(context, 'feed');
        }
      });
    }

    return const Center(child: CircularProgressIndicator());
  }
}
