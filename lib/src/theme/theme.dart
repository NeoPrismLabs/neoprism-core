/// Theme configuration for NeoPrism components, providing consistent styling options.
///
/// NeoPrismThemeData allows customization of border width, border radius, shadow effects,
/// and other style attributes that apply to all NeoPrism components.
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: ThemeData.light().copyWith(
///     extensions: [
///       const NeoPrismThemeData(
///         borderWidth: 3.0,
///         borderRadius: 12.0,
///         shadowOffset: Offset(4, 4),
///       ),
///     ],
///   ),
/// )
/// ```

library;

import 'dart:ui';

import 'package:flutter/material.dart';

/// Defines the visual properties for NeoPrism components.
///
/// This theme extension allows customization of neobrutalism styling elements
/// like border width, border radius, and shadow effects that are applied
/// consistently across all NeoPrism components.
class NeoPrismThemeData extends ThemeExtension<NeoPrismThemeData> {
  /// Width of borders for NeoPrism components in logical pixels.
  ///
  /// This controls the thickness of borders around components like buttons,
  /// inputs, and badges.
  final double borderWidth;

  /// Border radius for NeoPrism components in logical pixels.
  ///
  /// This controls the corner rounding of components like buttons,
  /// inputs, and badges.
  final double borderRadius;

  /// Shadow offset for the neobrutalism effect.
  ///
  /// This offset determines how shadows are positioned relative to components,
  /// creating the characteristic "stacked" or "layered" appearance of
  /// neobrutalism design.
  final Offset shadowOffset;

  /// Creates a NeoPrismThemeData with the specified properties.
  ///
  /// All parameters have default values that represent the standard
  /// neobrutalism styling if not explicitly provided.
  const NeoPrismThemeData({
    this.borderWidth = 3.0,
    this.borderRadius = 4.0,
    this.shadowOffset = const Offset(4, 4),
  });

  /// Creates a copy of this NeoPrismThemeData with the given fields replaced with new values.
  ///
  /// This method is used to create variations of the theme while
  /// preserving values that aren't explicitly changed.
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

  /// Linearly interpolate between two NeoPrismThemeData objects.
  ///
  /// The `t` parameter represents position on the timeline, with 0.0 meaning
  /// this object and 1.0 meaning `other`. Values between 0.0 and 1.0 represent
  /// a proportional mix of the two themes, allowing for smooth transitions.
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
