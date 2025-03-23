import 'package:neoprism_core/src/components/abstract/neoprism_component.dart';
import 'package:flutter/material.dart';
import 'package:neoprism_core/src/theme/theme.dart';

abstract class NeoprismComponentState<T extends NeoPrismComponent>
    extends State<T> {
  void trackInteraction(String action) {
    debugPrint('${widget.componentType} (${widget.id}): $action');
  }

  NeoPrismThemeData getThemeData(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<NeoPrismThemeData>() ?? const NeoPrismThemeData();
  }

  Widget applyNeoBrutalism({
    required Widget child,
    required BuildContext context,
    bool isPressed = false,
    bool isHovered = false,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Offset? shadowOffset,
  }) {
    final themeData = getThemeData(context);
    final theme = Theme.of(context);

    final Color effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary;
    final Color hoverBackgroundColor = Color.lerp(
        effectiveBackgroundColor, Colors.white, isHovered ? 0.1 : 0.0)!;

    final bool shouldMoveToCoverShadow = isPressed || isHovered;
    final Offset effectiveShadowOffset = shadowOffset ?? themeData.shadowOffset;

    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius:
            BorderRadius.circular(borderRadius ?? themeData.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: effectiveShadowOffset,
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.translationValues(
          shouldMoveToCoverShadow ? effectiveShadowOffset.dx : 0,
          shouldMoveToCoverShadow ? effectiveShadowOffset.dy : 0,
          0,
        )..scale(isPressed ? 0.98 : 1.0),
        decoration: BoxDecoration(
          color: hoverBackgroundColor,
          border: Border.all(
            color: borderColor ?? Colors.black,
            width: borderWidth ?? themeData.borderWidth,
          ),
          borderRadius:
              BorderRadius.circular(borderRadius ?? themeData.borderRadius),
        ),
        child: child,
      ),
    );
  }
}
