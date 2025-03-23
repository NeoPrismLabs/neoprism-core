import 'dart:ui';

import 'package:flutter/material.dart';

class NeoPrismThemeData extends ThemeExtension<NeoPrismThemeData> {
  final double borderWidth;
  final double borderRadius;
  final Offset shadowOffset;

  const NeoPrismThemeData({
    this.borderWidth = 3.0,
    this.borderRadius = 4.0,
    this.shadowOffset = const Offset(4, 4),
  });

  @override
  NeoPrismThemeData copyWith({
    double? borderWidth,
    double? borderRadius,
    Offset? shadowOffset,
  }) {
    return NeoPrismThemeData(
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      shadowOffset: shadowOffset ?? this.shadowOffset,
    );
  }

  @override
  ThemeExtension<NeoPrismThemeData> lerp(
    covariant ThemeExtension<NeoPrismThemeData>? other,
    double t,
  ) {
    if (other is! NeoPrismThemeData) {
      return this;
    }

    return NeoPrismThemeData(
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      borderRadius:
          lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      shadowOffset:
          Offset.lerp(shadowOffset, other.shadowOffset, t) ?? shadowOffset,
    );
  }
}
