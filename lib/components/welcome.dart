import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 225,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenido a tu',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Entrevista Técnica',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                ' en',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SvgPicture.asset('assets/svg/wacoName.svg')
        ],
      ),
    );
  }
}
