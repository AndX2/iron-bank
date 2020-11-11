import 'dart:math';

import 'package:flutter/material.dart';

/// Расширение для MediaQuery
extension ScreenSize on BuildContext {
  MediaQueryData get _query => MediaQuery.of(this);

  Orientation get orientation => _query.orientation;

  double get width => _query.size.width;

  double get height => _query.size.height;

  double get maxSize => max(width, height);

  double get diagonal =>
      sqrt(pow(_query.size.height, 2) + pow(_query.size.width, 2));
}
