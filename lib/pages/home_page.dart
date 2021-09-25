import 'package:flutter/material.dart';
import 'package:waco_mobile/Components/menu.dart';
import 'package:waco_mobile/components/benefits.dart';
import 'package:waco_mobile/components/tecnology.dart';
import 'package:waco_mobile/components/welcome.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/backgroundHome1.png',
                      fit: BoxFit.fitWidth,
                    )
                  ],
                ),
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 100,
                        ),
                        Welcome(),
                        Tecnology(),
                        Benefits()
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const Menu(),
        ]),
      ),
    );
  }
}
