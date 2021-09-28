import 'package:flutter/material.dart';
import 'package:waco_mobile/Components/menu.dart';
import 'package:waco_mobile/components/benefits.dart';
import 'package:waco_mobile/components/conoce_mas.dart';
import 'package:waco_mobile/components/footer.dart';
import 'package:waco_mobile/components/navigation.dart';
import 'package:waco_mobile/components/tecnology.dart';
import 'package:waco_mobile/components/welcome.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
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
                          Benefits(),
                          ConoceMas(),
                          Footer(),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Menu(buttonOnTap: () {
              _controller.forward();
            }),
            Navigation(
              controller: _controller,
              scrollController: _scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
