import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class _CarouselProvider {
  Future<List<Map<String, dynamic>>> loadData() async {
    List<Map<String, dynamic>> iconos = [];
    final resp = await rootBundle.loadString('assets/data/carousel.json');
    Map<String, dynamic> dataMap = json.decode(resp);
    for (var item in dataMap['icons']) {
      iconos.add(item);
    }
    return iconos;
  }
}

final carouselProvider = _CarouselProvider();
