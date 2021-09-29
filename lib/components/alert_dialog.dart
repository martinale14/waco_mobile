import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waco_mobile/utils/dimens.dart';

class InfoAlertDialog extends StatelessWidget {
  const InfoAlertDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: palette.surface,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: dimens.width(context, 0.4),
            child: SvgPicture.asset('assets/svg/title.svg'),
          ),
        ],
      ),
      elevation: 5,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(fontSize: 18, color: textTheme.bodyText1!.color),
          ),
        ],
      ),
      actionsPadding: dimens.fromLTRB(context, 0, 0, .02, .02),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'ok',
              style: TextStyle(fontSize: 20),
            ))
      ],
    );
  }
}
