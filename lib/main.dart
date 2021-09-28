import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:waco_mobile/pages/intermidiate.dart';
import 'package:waco_mobile/providers/user_provider.dart';
import 'package:waco_mobile/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error al conectarse con Firebase'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
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
        home: const Intermidiate(
          subscribe: true,
        ),
        routes: getRoutes(),
      ),
    );
  }
}
