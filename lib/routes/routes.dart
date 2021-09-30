import 'package:flutter/material.dart';
import 'package:waco_mobile/pages/favorites.dart';
import 'package:waco_mobile/pages/feed.dart';
import 'package:waco_mobile/pages/home_page.dart';
import 'package:waco_mobile/pages/intermidiate.dart';
import 'package:waco_mobile/pages/login_page.dart';
import 'package:waco_mobile/pages/registro.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    "home": (BuildContext context) => const HomePage(),
    "login": (BuildContext context) => const Login(),
    "registro": (BuildContext context) => const Registro(),
    "intermediate": (BuildContext context) => const Intermediate(),
    "feed": (BuildContext context) => const Feed(),
    "favorites": (BuildContext context) => const Favorites(),
  };
}
