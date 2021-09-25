import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tecnology extends StatelessWidget {
  const Tecnology({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 65,
              ),
              SvgPicture.asset('assets/svg/greenBackground.svg')
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/tecnology.png'),
              Text(
                'Trabajamos para',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Convertir ideas',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3),
                  Text(' en',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('productos',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3)
            ],
          )
        ],
      ),
    );
  }
}
