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
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
  }) {
    final themeData = getThemeData(context);
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      transform: isPressed
          ? Matrix4.translationValues(
              themeData.shadowOffset.dx / 2, themeData.shadowOffset.dy / 2, 0)
          : Matrix4.translationValues(0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.colorScheme.primary,
          border: Border.all(
            color: borderColor ?? Colors.black,
            width: borderWidth ?? themeData.borderWidth,
          ),
          borderRadius:
              BorderRadius.circular(borderRadius ?? themeData.borderRadius),
          boxShadow: isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black,
                    offset: themeData.shadowOffset,
                    blurRadius: 0,
                  ),
                ],
        ),
        child: child,
      ),
    );
  }
}
