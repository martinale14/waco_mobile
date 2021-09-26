import 'package:flutter/material.dart';
import 'package:waco_mobile/pages/home_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    "home": (BuildContext context) => const HomePage()
  };
}
