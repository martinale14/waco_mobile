import 'dart:math';
import 'package:flutter/material.dart';
import 'package:waco_mobile/providers/carousel_provider.dart';

class BenefitsCarousel extends StatefulWidget {
  const BenefitsCarousel({Key? key}) : super(key: key);

  @override
  _BenefitsCarouselState createState() => _BenefitsCarouselState();
}

class _BenefitsCarouselState extends State<BenefitsCarousel> {
  late ScrollController scrollController;
  List<double> scrollPositions = [];
  List<Widget> iconItems = [];
  List<Widget> dots = [];
  int currentScroll = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.98,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
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
                    setState(() {
                      currentScroll =
                          currentScroll != 0 ? currentScroll - 1 : 0;
                      scrollController.animateTo(scrollPositions[currentScroll],
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    });
                  },
                  child: Transform.rotate(
                    angle: pi,
                    child:
                        Image.asset('assets/images/carousel/arrowControl.png'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: _getIconsList(),
                ),
                InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    onTap: () {
                      setState(() {
                        currentScroll =
                            currentScroll != scrollPositions.length - 1
                                ? currentScroll + 1
                                : scrollPositions.length - 1;
                      });
                      scrollController.animateTo(scrollPositions[currentScroll],
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    },
                    child:
                        Image.asset('assets/images/carousel/arrowControl.png'))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: dots,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getIconsList() {
    return FutureBuilder(
        future: carouselProvider.loadData(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _carouselItem(snapshot.data, context),
            ),
          );
        });
  }

  List<Widget> _carouselItem(List<dynamic>? data, context) {
    if (data != null) {
      for (var icon in data) {
        iconItems.add(SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Image.asset(icon['route'])));
      }
    }

    initializeScrollList(context);
    debugPrint('jumm');
    return iconItems;
  }

  void initializeScrollList(BuildContext context) {
    debugPrint('hola');
    int pieces = iconItems.length ~/ 2;
    const double step = 275;
    for (int i = 0; i < pieces; i++) {
      scrollPositions.add(i == 0 ? 0 : (scrollPositions[i - 1] + step));
      dots.add(AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: i == currentScroll ? 1 : 0.2,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ]),
              borderRadius: const BorderRadius.all(Radius.circular(100))),
        ),
      ));

      if (i != pieces - 1) {
        dots.add(const SizedBox(
          width: 15,
        ));
      }
    }
  }
}
