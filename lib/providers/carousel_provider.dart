import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class _CarouselProvider {
  List<dynamic> iconos = [];

  _CarouselProvider();

  Future<List<dynamic>> loadData() async {
    final resp = await rootBundle.loadString('assets/data/carousel.json');

    Map dataMap = json.decode(resp);
    iconos = dataMap['icons'];
    return iconos;
  }
}

final carouselProvider = _CarouselProvider();
