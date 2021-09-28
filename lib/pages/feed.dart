import 'package:flutter/material.dart';
import 'package:waco_mobile/components/drawer.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key, required this.uid, this.email}) : super(key: key);

  final String uid;
  final String? email;

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: palette.background,
        drawer: FeedDrawer(
          email: email,
          uid: uid,
        ));
  }
}
