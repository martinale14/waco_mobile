import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:waco_mobile/routes/rutas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waco Mobile',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
      theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: const ColorScheme(
              primary: Color(0xFF00FF68),
              onPrimary: Color(0xFF0E0E0E),
              primaryVariant: Color(0xFF00FF68),
              secondary: Color(0xFF00E6E3),
              onSecondary: Color(0xFF0E0E0E),
              secondaryVariant: Color(0xFF00E6E3),
              background: Color(0xFF0E0E0E),
              onBackground: Colors.white,
              surface: Color(0xFF232323),
              onSurface: Colors.white,
              error: Colors.yellow,
              onError: Colors.red,
              brightness: Brightness.light),
          textTheme: const TextTheme(
              headline1: TextStyle(
                  color: Color(0xFF0E0E0E),
                  fontWeight: FontWeight.w300,
                  fontSize: 36),
              headline2: TextStyle(
                  color: Color(0xFF0E0E0E),
                  fontWeight: FontWeight.w600,
                  fontSize: 36),
              headline3: TextStyle(
                  color: Color(0xFF0E0E0E),
                  fontWeight: FontWeight.w900,
                  fontSize: 36),
              bodyText1: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 34),
              bodyText2: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 34))),
      initialRoute: 'home',
      routes: getRoutes(),
    );
  }
}
