import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waco_mobile/components/custom_toast.dart';
import 'package:waco_mobile/components/gradient_button.dart';
import 'package:waco_mobile/components/input.dart';
import 'package:waco_mobile/components/menu.dart';
import 'package:waco_mobile/components/navigation.dart';
import 'package:waco_mobile/utils/dimens.dart';

import 'login_page.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _comfirmPasswordController;
  String emailValidationText = '';
  String passwordValidationText = '';
  String comfirmPasswordValidationText = '';

  final FToast toast = FToast();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _scrollController = ScrollController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _comfirmPasswordController = TextEditingController();
    toast.init(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _comfirmPasswordController.dispose();
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
                                    'Registro',
                                    style: TextStyle(
                                        foreground: Paint()
                                          ..shader = linearGradient),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                CustomInput(
                                  validationText: emailValidationText,
                                  label: 'Correo',
                                  controller: _emailController,
                                  onChange: (value) {
                                    setState(() {
                                      emailValidationText =
                                          Validator.validateEmail(value);
                                    });
                                  },
                                  type: TextInputType.emailAddress,
                                  icon: Icons.email,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomInput(
                                  validationText: passwordValidationText,
                                  label: 'Contraseña',
                                  controller: _passwordController,
                                  onChange: (value) {
                                    setState(() {
                                      passwordValidationText =
                                          Validator.validateNewPassword(value);
                                      comfirmPasswordValidationText =
                                          Validator.validateConfirmation(
                                              _comfirmPasswordController.text,
                                              value);
                                    });
                                  },
                                  hideContent: true,
                                  icon: Icons.lock,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomInput(
                                  validationText: comfirmPasswordValidationText,
                                  label: 'Comfirmar contraseña',
                                  controller: _comfirmPasswordController,
                                  onChange: (value) {
                                    setState(() {
                                      comfirmPasswordValidationText =
                                          Validator.validateConfirmation(
                                              value, _passwordController.text);
                                    });
                                  },
                                  hideContent: true,
                                  icon: Icons.lock,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Button(
                                  label: 'Crear cuenta',
                                  buttonTap: () async {
                                    if ((_emailController.text.isEmpty ||
                                            _passwordController.text.isEmpty ||
                                            _comfirmPasswordController
                                                .text.isEmpty) ||
                                        (emailValidationText.isNotEmpty ||
                                            passwordValidationText.isNotEmpty ||
                                            comfirmPasswordValidationText
                                                .isNotEmpty)) {
                                      toast.showToast(
                                        gravity: ToastGravity.TOP,
                                        child: const CustomToast(
                                            msg:
                                                'Por favor llene correctamente el formulario'),
                                      );
                                    }
                                    if (emailValidationText.isEmpty &&
                                        passwordValidationText.isEmpty &&
                                        comfirmPasswordValidationText.isEmpty) {
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text);
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text);
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                'intermediate',
                                                (Route<dynamic> route) =>
                                                    false);
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          debugPrint(
                                              'The password provided is too weak.');
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          toast.showToast(
                                            gravity: ToastGravity.TOP,
                                            child: const CustomToast(
                                                msg:
                                                    'El correo ya se encuentra en uso'),
                                          );
                                        }
                                      } catch (e) {
                                        debugPrint(e.toString());
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
