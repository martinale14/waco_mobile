import 'package:flutter/material.dart';
import 'package:waco_mobile/utils/dimens.dart';
import 'package:url_launcher/url_launcher.dart';

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

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
          onTap: () async {
            const String url = 'https://wacoservices.com/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  content: const Text('La página web no puede ser lanzada'),
                  action: SnackBarAction(
                    textColor: Theme.of(context).textTheme.bodyText1!.color,
                    label: 'vale',
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: dimens.width(context, .48),
            height: dimens.height(context, .07),
            child: Text(
              'Conocer más',
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
