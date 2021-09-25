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
  Container ct = Container(
    width: 20,
  );
  List<Widget> iconItems = [];
  int currentScroll = 0;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    /* scrollController.addListener(() {
      debugPrint(scrollController.offset.toString());
    }); */
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              onTap: () {
                scrollPositions.isEmpty ? initializeScrollList(context) : null;
                currentScroll = currentScroll != 0 ? currentScroll - 1 : 0;
                scrollController.animateTo(scrollPositions[currentScroll],
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut);
              },
              child: Transform.rotate(
                angle: pi,
                child: Image.asset('assets/images/carousel/arrowControl.png'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: _getIconsList(),
            ),
            InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                onTap: () {
                  scrollPositions.isEmpty
                      ? initializeScrollList(context)
                      : null;
                  currentScroll = currentScroll != scrollPositions.length - 1
                      ? currentScroll + 1
                      : scrollPositions.length - 1;
                  scrollController.animateTo(scrollPositions[currentScroll],
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                },
                child: Image.asset('assets/images/carousel/arrowControl.png'))
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
            //physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            child: Row(
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
    return iconItems;
  }

  void initializeScrollList(BuildContext context) {
    int pieces = iconItems.length ~/ 2;
    double step = 183.27;
    debugPrint(step.toString());
    scrollPositions.add(scrollController.position.minScrollExtent);
    for (int i = 1; i < pieces - 1; i++) {
      if (i == 1) {
        scrollPositions.add(scrollPositions[i - 1] + (step * 3 / 2));
      } else {
        scrollPositions.add(scrollPositions[i - 1] + step);
      }
    }
    scrollPositions.add(scrollController.position.maxScrollExtent);

    debugPrint(scrollPositions.toString());
  }
}
