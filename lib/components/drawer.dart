import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waco_mobile/utils/dimens.dart';

class FeedDrawer extends StatelessWidget {
  const FeedDrawer({Key? key, required this.uid, this.email}) : super(key: key);

  final String uid;
  final String? email;

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    return Drawer(
      child: Container(
        color: palette.surface,
        child: ListView(
          padding: dimens.symmetric(context, .01, 0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [palette.primary, palette.secondary])),
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    color: palette.onPrimary,
                    size: 100,
                  ),
                  Text(
                    email ?? 'Email',
                    style: TextStyle(
                        fontSize: 20,
                        color: palette.onPrimary,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            ListTile(
              trailing: const Icon(
                Icons.home,
                color: Colors.white70,
              ),
              title: const Text('Inicio', style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            ListTile(
              trailing: const Icon(
                Icons.favorite,
                color: Colors.white70,
              ),
              title: const Text('Favoritos', style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            ListTile(
              trailing: const Icon(
                Icons.close,
                color: Colors.white70,
              ),
              title:
                  const Text('Cerrar Sesión', style: TextStyle(fontSize: 20)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
