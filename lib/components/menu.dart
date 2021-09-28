import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waco_mobile/Components/menu_btn.dart';
import 'package:waco_mobile/utils/dimens.dart';

class Menu extends StatelessWidget {
  final Function buttonOnTap;
  final bool? close;

  const Menu({Key? key, required this.buttonOnTap, this.close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          top: 0,
          left: 0,
          height: 110,
          width: dimens.width(context, 1),
          child: ClipRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          )),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 18),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.46,
                    height: 110,
                    child: SvgPicture.asset(
                      'assets/svg/title.svg',
                    ),
                  ),
                  MenuButton(
                    close: close ?? false,
                    buttonOnTap: () {
                      buttonOnTap();
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: Theme.of(context).colorScheme.surface,
            )
          ],
        ),
      ],
    );
  }
}
