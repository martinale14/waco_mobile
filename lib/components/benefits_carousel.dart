import 'dart:math';
import 'package:flutter/material.dart';
import 'package:waco_mobile/utils/dimens.dart';
import 'package:waco_mobile/components/icon_list.dart';

class BenefitsCarousel extends StatefulWidget {
  const BenefitsCarousel({Key? key}) : super(key: key);

  @override
  _BenefitsCarouselState createState() => _BenefitsCarouselState();
}

class _BenefitsCarouselState extends State<BenefitsCarousel> {
  late PageController pageController;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimens.fullWidth(context),
      child: Padding(
        padding: dimens.fromLTRB(context, .01, .3, .01, .01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  onTap: () {
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  child: Transform.rotate(
                    angle: pi,
                    child:
                        Image.asset('assets/images/carousel/arrowControl.png'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: IconList(
                    controller: pageController,
                    currentPage: currentPage,
                  ),
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  onTap: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  child: Image.asset('assets/images/carousel/arrowControl.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
