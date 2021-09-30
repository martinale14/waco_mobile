import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waco_mobile/Components/menu.dart';
import 'package:waco_mobile/components/alert_dialog.dart';
import 'package:waco_mobile/components/custom_toast.dart';
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
  String emailValidationText = '';
  String passwordValidationText = '';

  final FToast toast = FToast();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _scrollController = ScrollController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    toast.init(context);
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
                                          Validator.validatePassword(value);
                                    });
                                  },
                                  hideContent: true,
                                  icon: Icons.lock,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Button(
                                  label: 'Login',
                                  buttonTap: () async {
                                    if ((_emailController.text.isEmpty ||
                                            _passwordController.text.isEmpty) ||
                                        (emailValidationText.isNotEmpty ||
                                            passwordValidationText
                                                .isNotEmpty)) {
                                      toast.showToast(
                                        gravity: ToastGravity.TOP,
                                        child: const CustomToast(
                                            msg:
                                                'Por favor llene correctamente el formulario'),
                                      );
                                    }
                                    if (emailValidationText.isEmpty &&
                                        passwordValidationText.isEmpty) {
                                      try {
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
                                        if (e.code == 'user-not-found') {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return const InfoAlertDialog(
                                                    message:
                                                        'Usuario no encontrado');
                                              });
                                        } else if (e.code == 'wrong-password') {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return const InfoAlertDialog(
                                                    message:
                                                        'Contraseña incorrecta');
                                              });
                                        }
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(height: 50),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'registro');
                                  },
                                  child: Text(
                                    'Crear una cuenta',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300),
                                  ),
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

class Validator {
  static String validateEmail(String email) {
    String validationMessage = '';

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      validationMessage = 'Dirección de correo invalida';
    }
    if (email.isEmpty) {
      validationMessage = 'El campo no debe estar vacío';
    }

    return validationMessage;
  }

  static String validatePassword(String password) {
    String validationMessage = '';

    if (password.length < 6) {
      validationMessage = 'La contraseña debe tener al menos 6 caracteres';
    }
    if (password.isEmpty) {
      validationMessage = 'El campo no debe estar vacío';
    }

    return validationMessage;
  }

  static String validateConfirmation(String value, String password) {
    String validationMessage = '';

    if (value != password) {
      validationMessage = 'Las contraseñas no coinciden';
    }

    return validationMessage;
  }

  static String validateNewPassword(String password) {
    String validationMessage = '';

    bool hasUppercase = false;
    bool hasLowercase = false;
    bool hasNumber = false;
    bool hasSpecialCharacter =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (password.isEmpty) {
      return 'El campo no debe estar vacío';
    }

    if (password.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    for (int i = 0; i < password.length; i++) {
      if (password[i] == password[i].toUpperCase() &&
          !isDigit(password[i], 0)) {
        hasUppercase = true;
      }
      if (password[i] == password[i].toLowerCase() &&
          !isDigit(password[i], 0)) {
        hasLowercase = true;
      }

      if (isDigit(password[i], 0)) {
        hasNumber = true;
      }
    }

    validationMessage += hasUppercase ? '' : '\n Mínimo una mayúscula';
    validationMessage += hasLowercase ? '' : '\n Mínimo una minúscula';
    validationMessage += hasNumber ? '' : '\n Mínimo un número';
    validationMessage +=
        hasSpecialCharacter ? '' : '\n Mínimo un caracter especial';

    return validationMessage;
  }

  static bool isDigit(String s, int idx) =>
      "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;
}
