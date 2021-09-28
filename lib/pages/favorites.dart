import 'package:flutter/material.dart';
import 'package:waco_mobile/components/drawer.dart';
import 'package:waco_mobile/components/menu_btn.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          actions: [
            Builder(
              builder: (context) => MenuButton(
                buttonOnTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
          title: const Text('Favorites',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(),
          ),
        ),
        backgroundColor: palette.background,
        endDrawer: const FeedDrawer());
  }
}
