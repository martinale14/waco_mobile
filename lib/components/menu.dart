import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waco_mobile/Components/menu_btn.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              const MenuButton()
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 2,
          color: Theme.of(context).colorScheme.surface,
        )
      ],
    );
  }
}
