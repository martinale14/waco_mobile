import 'package:flutter/material.dart';
import 'package:waco_mobile/components/benefits_carousel.dart';

class Benefits extends StatelessWidget {
  const Benefits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme palette = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Entre los',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                height: 45,
                alignment: Alignment.center,
                child: Text(
                  'beneficios',
                  style: textTheme.headline2,
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [palette.primary, palette.secondary])),
              ),
              Text(
                '  que',
                style: textTheme.bodyText1,
              )
            ],
          ),
          Text('ofrecemos', style: textTheme.bodyText2),
          Text('se encuentran', style: textTheme.bodyText1),
          const BenefitsCarousel()
        ],
      ),
    );
  }
}
