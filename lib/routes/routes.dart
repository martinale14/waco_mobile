import 'package:flutter/material.dart';
import 'package:waco_mobile/pages/home_page.dart';
import 'package:waco_mobile/pages/intermidiate.dart';
import 'package:waco_mobile/pages/login_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    "home": (BuildContext context) => const HomePage(),
    "login": (BuildContext context) => const Login(),
    "intermidiate": (BuildContext context) => const Intermidiate(),
  };
}
