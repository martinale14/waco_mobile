import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waco_mobile/providers/user_provider.dart';
import 'package:waco_mobile/utils/dimens.dart';

class FeedDrawer extends StatelessWidget {
  const FeedDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    final UserProvider user = Provider.of(context);
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
                    user.email,
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
              onTap: () {
                if (ModalRoute.of(context)!.settings.name != 'feed') {
                  Navigator.pushReplacementNamed(context, 'feed');
                }
              },
            ),
            ListTile(
              trailing: const Icon(
                Icons.favorite,
                color: Colors.white70,
              ),
              title: const Text('Favoritos', style: TextStyle(fontSize: 20)),
              onTap: () {
                if (ModalRoute.of(context)!.settings.name != 'favorites') {
                  Navigator.pushReplacementNamed(context, 'favorites');
                }
              },
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
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'intermediate', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
