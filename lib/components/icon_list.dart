import 'package:flutter/material.dart';
import 'package:waco_mobile/utils/dimens.dart';
import 'package:waco_mobile/providers/carousel_provider.dart';

class IconList extends StatefulWidget {
  const IconList(
      {Key? key, required this.controller, required this.currentPage})
      : super(key: key);

  final PageController controller;
  final int currentPage;

  @override
  State<IconList> createState() => _IconListState();
}

class _IconListState extends State<IconList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: carouselProvider.loadData(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: dimens.width(context, .6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: dimens.width(context, 1),
                  height: 250,
                  child: PageView.builder(
                    controller: widget.controller,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {},
                    itemCount: snapshot.data!.length ~/ 2,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _IconItem(
                            data: snapshot.data![index + index],
                          ),
                          _IconItem(
                            data: snapshot.data![index + (index + 1)],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                _Dots(
                  pageCount: snapshot.data!.length ~/ 2,
                  currentPage: widget.currentPage,
                )
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}

class _IconItem extends StatelessWidget {
  const _IconItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      data['route'],
      width: dimens.width(context, .35),
    );
  }
}

class _Dots extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  const _Dots({Key? key, required this.pageCount, this.currentPage = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    return Container(
      alignment: Alignment.center,
      width: dimens.width(context, .8),
      height: 20,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: pageCount,
          itemBuilder: (context, index) {
            return (AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: index == currentPage ? 1 : 0.2,
              child: Container(
                width: 20,
                alignment: Alignment.center,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [palette.primary, palette.secondary]),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                ),
              ),
            ));
          }),
    );
  }
}

/* 
Container(
  height: 8,
  width: dimens.fullWidth(context),
  alignment: Alignment.center,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemCount: 3,
    itemBuilder: (context, index) {
      return AnimatedContainer(
        height: 8,
        width: index == actualPage ? 24 : 8,
        margin: dimens.horizontal(context, .015),
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: index == actualPage
              ? colors.mainStartGreen
              : colors.terciaryGreen,
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      );
    },
  ),
),
 */