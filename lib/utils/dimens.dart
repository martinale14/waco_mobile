/// Imports flutter
import 'package:flutter/material.dart';

/// Clase para manejar dimensiones proprocionales al tamaño de la pantalla
class Dimens {
  /// Total width of the screen
  double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Total height of the screen
  double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Return proportional width
  double width(BuildContext context, double value) {
    return fullWidth(context) * value;
  }

  /// Return proportional height
  double height(BuildContext context, double value) {
    return fullHeight(context) * value;
  }

  /// Use in padding or margin based in the total width of the screen
  EdgeInsets fromLTRB(
    BuildContext context,
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return EdgeInsets.fromLTRB(
      fullWidth(context) * left,
      fullWidth(context) * top,
      fullWidth(context) * right,
      fullWidth(context) * bottom,
    );
  }

  /// Use a symmetric padding or margin in horizontal or vertical axis
  /// based in the total [width] of the screen
  EdgeInsets symmetric(
    BuildContext context,
    double horizontal,
    double vertical,
  ) {
    return EdgeInsets.symmetric(
      vertical: fullWidth(context) * vertical,
      horizontal: fullWidth(context) * horizontal,
    );
  }

  /// Use a all sides padding or margin
  /// based in the total width of the screen
  EdgeInsets all(BuildContext context, double value) {
    return EdgeInsets.all(
      fullWidth(context) * value,
    );
  }

  /// Use in a padding or margin in horizontal axis
  EdgeInsets horizontal(BuildContext context, double value) {
    return EdgeInsets.symmetric(
      horizontal: fullWidth(context) * value,
    );
  }

  /// Use in a padding or margin in vertical axis
  EdgeInsets vertical(BuildContext context, double value) {
    return EdgeInsets.symmetric(
      vertical: fullWidth(context) * value,
    );
  }

  /// Use in only top padding or margin
  EdgeInsets top(BuildContext context, double value) {
    return EdgeInsets.only(
      top: fullWidth(context) * value,
    );
  }

  /// Use in only left padding or margin
  EdgeInsets left(BuildContext context, double value) {
    return EdgeInsets.only(
      left: fullWidth(context) * value,
    );
  }

  /// Use in only right padding or margin
  EdgeInsets right(BuildContext context, double value) {
    return EdgeInsets.only(
      right: fullWidth(context) * value,
    );
  }

  /// Use in only bottom padding or margin
  EdgeInsets bottom(BuildContext context, double value) {
    return EdgeInsets.only(
      bottom: fullWidth(context) * value,
    );
  }

  /// Border radius based in the total width of the screen
  /// [radius] number that indicates the total radius to implement
  BorderRadius borderRadius(BuildContext context, double radius) {
    return BorderRadius.all(Radius.circular(fullWidth(context) * radius));
  }
}

/// Exporta la clase [Dimens]
Dimens dimens = Dimens();
