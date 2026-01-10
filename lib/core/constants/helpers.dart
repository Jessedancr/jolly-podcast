import 'package:flutter/material.dart';

extension JollyPodcastColorScheme on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension ScreenDimensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
