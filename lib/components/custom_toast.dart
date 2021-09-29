import 'package:flutter/material.dart';
import 'package:waco_mobile/utils/dimens.dart';

class CustomToast extends StatelessWidget {
  const CustomToast({Key? key, required this.msg}) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) => Container(
        padding: dimens.symmetric(context, 0.05, 0.05),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Text(
                msg,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      );
}
