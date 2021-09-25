import 'dart:math';

import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _consecutive;
  late Animation _middleSize;
  late Animation _margin;
  late Animation _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    _consecutive = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    _middleSize = Tween<double>(begin: 30, end: 0).animate(_controller)
      ..addListener(() {
        _controller.isCompleted ? _consecutive.forward() : null;
        setState(() {});
      });
    _margin = Tween<double>(begin: 20, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _rotation = Tween<double>(begin: 0, end: 45).animate(_consecutive)
      ..addListener(() {
        _consecutive.isDismissed ? _controller.reverse() : null;
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      onTap: () {
        _controller.isCompleted
            ? _consecutive.reverse()
            : _controller.forward();
      },
      child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.width * 0.12,
          padding: const EdgeInsets.all(5),
          child: Stack(alignment: Alignment.center, children: [
            buildPiece(
                margin: EdgeInsets.only(bottom: _margin.value),
                rotation: _rotation.value),
            buildPiece(width: _middleSize.value),
            buildPiece(
                margin: EdgeInsets.only(top: _margin.value),
                rotation: -_rotation.value)
          ])),
    );
  }

  Widget buildPiece(
      {EdgeInsetsGeometry? margin, double? width, double? rotation}) {
    return Transform.rotate(
      angle: (rotation ?? 0) * (pi / 180),
      alignment: Alignment.center,
      child: (Container(
        margin: margin ?? EdgeInsets.zero,
        height: 3,
        width: width ?? 30,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ])),
      )),
    );
  }
}
