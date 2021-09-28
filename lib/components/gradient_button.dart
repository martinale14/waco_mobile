import 'package:flutter/material.dart';
import 'package:waco_mobile/utils/dimens.dart';

class Button extends StatelessWidget {
  final Function buttonTap;
  final String label;

  const Button({Key? key, required this.buttonTap, this.label = 'Button'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      alignment: Alignment.center,
      children: [
        Ink(
          width: dimens.width(context, .48),
          height: dimens.height(context, .07),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            gradient: LinearGradient(
              colors: [
                palette.primary,
                palette.secondary,
              ],
            ),
          ),
        ),
        InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          onTap: () {
            buttonTap();
          },
          child: Container(
            alignment: Alignment.center,
            width: dimens.width(context, .48),
            height: dimens.height(context, .07),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: textTheme.headline1!.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
