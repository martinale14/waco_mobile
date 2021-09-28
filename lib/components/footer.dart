import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waco_mobile/utils/dimens.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 85,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 2,
          color: Theme.of(context).colorScheme.surface,
        ),
        SizedBox(
          height: dimens.height(context, .14),
          width: dimens.width(context, .4),
          child: SvgPicture.asset('assets/svg/title.svg'),
        ),
      ],
    );
  }
}
