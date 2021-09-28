import 'dart:math';

import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  final Function buttonOnTap;
  final bool close;
  const MenuButton({Key? key, required this.buttonOnTap, this.close = false})
      : super(key: key);

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      onTap: () {
        widget.buttonOnTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.width * 0.12,
        padding: const EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildPiece(
              margin: EdgeInsets.only(bottom: widget.close ? 0 : 20),
              angle: widget.close ? 45 : 0,
            ),
            buildPiece(width: widget.close ? 0 : 30),
            buildPiece(
              margin: EdgeInsets.only(top: widget.close ? 0 : 20),
              angle: widget.close ? -45 : 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPiece(
      {EdgeInsetsGeometry? margin, double? width, double angle = 0}) {
    return Transform.rotate(
      angle: angle * (pi / 180),
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
