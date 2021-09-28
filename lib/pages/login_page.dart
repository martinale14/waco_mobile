import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waco_mobile/Components/menu.dart';
import 'package:waco_mobile/components/gradient_button.dart';
import 'package:waco_mobile/components/input.dart';
import 'package:waco_mobile/components/navigation.dart';
import 'package:waco_mobile/utils/dimens.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _scrollController = ScrollController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    Shader linearGradient =
        LinearGradient(colors: [palette.primary, palette.secondary])
            .createShader(const Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));
    return Scaffold(
        backgroundColor: palette.background,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 130,
                            ),
                            Image.asset(
                              'assets/images/conoceMasBg.png',
                              fit: BoxFit.fitWidth,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Transform.rotate(
                              angle: pi,
                              child: Image.asset(
                                'assets/images/conoceMasBg.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 150,
                                ),
                                SizedBox(
                                  width: dimens.width(context, .8),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        foreground: Paint()
                                          ..shader = linearGradient),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                CustomInput(
                                  label: 'Correo',
                                  controller: _emailController,
                                  onChange: (value) {},
                                  type: TextInputType.emailAddress,
                                  icon: const Icon(
                                    Icons.email,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomInput(
                                  label: 'Contraseña',
                                  controller: _passwordController,
                                  onChange: (value) {},
                                  hideContent: true,
                                  icon: const Icon(
                                    Icons.lock,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Button(
                                  label: 'Login',
                                  buttonTap: () async {
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text);
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        debugPrint(
                                            'No user found for that email.');
                                      } else if (e.code == 'wrong-password') {
                                        debugPrint(
                                            'Wrong password provided for that user.');
                                      }
                                    }
                                  },
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Menu(
                      close: true,
                      buttonOnTap: () {
                        Navigator.pop(context);
                      }),
                  Navigation(
                    controller: _controller,
                    scrollController: _scrollController,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
