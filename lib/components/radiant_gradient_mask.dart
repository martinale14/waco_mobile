import 'package:flutter/material.dart';

class LinearGradientMask extends StatelessWidget {
  const LinearGradientMask({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [palette.primary, palette.secondary],
      ).createShader(bounds),
      child: child,
    );
  }
}
