import 'package:flutter/material.dart';
import 'package:waco_mobile/utils/dimens.dart';
import 'package:waco_mobile/Components/menu_btn.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navigation extends StatefulWidget {
  final AnimationController controller;

  const Navigation({Key? key, required this.controller}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.easeInOut,
      ),
    );
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          IgnorePointer(
            ignoring: _opacityAnimation.isCompleted ? false : true,
            child: Container(
              alignment: Alignment.topCenter,
              color:
                  const Color(0xFF0E0E0E).withOpacity(_opacityAnimation.value),
              width: dimens.width(context, 1),
              height: dimens.height(context, 1),
            ),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                        close: true,
                        buttonOnTap: () {
                          widget.controller.reverse();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Container(
                    alignment: Alignment.center,
                    width: dimens.width(context, .4),
                    height: dimens.height(context, .08),
                    child: const Text(
                      'INICIO',
                      style:
                          TextStyle(fontWeight: FontWeight.w100, fontSize: 24),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Container(
                    alignment: Alignment.center,
                    width: dimens.width(context, .4),
                    height: dimens.height(context, .08),
                    child: const Text(
                      'BENEFICIOS',
                      style:
                          TextStyle(fontWeight: FontWeight.w100, fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
