/// A neobrutalism-styled badge component for displaying status indicators,
/// counters, or informational labels.
///
/// NeoBadge comes in various types including standard labels, status indicators,
/// counters, and dot badges. Each type can be customized with different colors,
/// sizes, and styles.
///
/// Example:
/// ```dart
/// NeoBadge(
///   id: 'status_badge',
///   label: 'New',
///   backgroundColor: Colors.blue,
/// )
/// ```

library;

import 'package:flutter/material.dart';
import '../abstract/neoprism_component.dart';
import '../abstract/neoprism_state.dart';

enum NeoBadgeSize {
  small,
  medium,
  large,
}

enum NeoBadgeType {
  standard,
  status,
  counter,
  dot,
}

class NeoBadge extends NeoPrismComponent {
  const NeoBadge({
    required super.id,
    this.label,
    this.shadowOffset = const Offset(0, 0),
    this.icon,
    this.child,
    this.backgroundColor,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.size = NeoBadgeSize.medium,
    this.type = NeoBadgeType.standard,
    this.count,
    this.isOutlined = false,
    this.padding,
    super.key,
  }) : assert(
          (type == NeoBadgeType.counter && count != null) ||
              (type != NeoBadgeType.counter) ||
              child != null,
          'Counter badges require a count, and non-counter badges require either a label, icon, or custom child.',
        );
  factory NeoBadge.status({
    required String id,
    required String label,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    NeoBadgeSize size,
    bool isOutlined,
    Offset? shadowOffset,
    Key? key,
  }) = _NeoStatusBadge;
  factory NeoBadge.dot({
    required String id,
    Color? backgroundColor,
    Color? borderColor,
    Offset? shadowOffset,
    Key? key,
  }) = _NeoDotBadge;
  final String? label;
  final Widget? icon;
  final Widget? child;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final NeoBadgeSize size;
  final NeoBadgeType type;
  final int? count;
  final bool isOutlined;
  final EdgeInsetsGeometry? padding;
  final Offset? shadowOffset;

  factory NeoBadge.counter({
    required String id,
    required int count,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    NeoBadgeSize size,
    bool isOutlined,
    Offset? shadowOffset,
    Key? key,
  }) = _NeoCounterBadge;

  @override
  String get componentType => 'NeoBadge';

  @override
  State<NeoBadge> createState() => _NeoBadgeState();
}

class _NeoStatusBadge extends NeoBadge {
  _NeoStatusBadge({
    required String id,
    required String label,
    Color? backgroundColor,
    Color? textColor = Colors.black,
    Color? borderColor = Colors.black,
    NeoBadgeSize size = NeoBadgeSize.small,
    bool isOutlined = false,
    Offset? shadowOffset = const Offset(0, 0),
    Key? key,
  }) : super(
          id: id,
          label: label,
          backgroundColor: backgroundColor,
          textColor: textColor,
          borderColor: borderColor,
          size: size,
          type: NeoBadgeType.status,
          isOutlined: isOutlined,
          shadowOffset: shadowOffset,
          key: key,
        );
}

class _NeoCounterBadge extends NeoBadge {
  _NeoCounterBadge({
    required String id,
    required int count,
    Color? backgroundColor,
    Color? textColor = Colors.black,
    Color? borderColor = Colors.black,
    NeoBadgeSize size = NeoBadgeSize.small,
    bool isOutlined = false,
    Offset? shadowOffset = const Offset(0, 0),
    Key? key,
  }) : super(
          id: id,
          count: count,
          backgroundColor: backgroundColor,
          textColor: textColor,
          borderColor: borderColor,
          size: size,
          type: NeoBadgeType.counter,
          isOutlined: isOutlined,
          shadowOffset: shadowOffset,
          key: key,
        );
}

class _NeoDotBadge extends NeoBadge {
  _NeoDotBadge({
    required String id,
    Color? backgroundColor,
    Color? borderColor = Colors.black,
    Offset? shadowOffset = const Offset(0, 0),
    Key? key,
  }) : super(
          id: id,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          size: NeoBadgeSize.small,
          type: NeoBadgeType.dot,
          shadowOffset: shadowOffset,
          key: key,
        );
}

class _NeoBadgeState extends NeoprismComponentState<NeoBadge> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neoTheme = getThemeData(context);

    double height;
    double minWidth;
    double fontSize;
    double borderWidth = widget.isOutlined ? 1 : neoTheme.borderWidth;
    double borderRadius = neoTheme.borderRadius;

    switch (widget.size) {
      case NeoBadgeSize.small:
        height = 20;
        minWidth = 20;
        fontSize = 10;
        borderRadius = neoTheme.borderRadius * 0.8;
        break;
      case NeoBadgeSize.large:
        height = 32;
        minWidth = 32;
        fontSize = 14;
        break;
      case NeoBadgeSize.medium:
        height = 24;
        minWidth = 24;
        fontSize = 12;
    }

    if (widget.type == NeoBadgeType.dot) {
      height = 12;
      minWidth = 12;
      borderWidth = borderWidth * 0.75;
    }

    final Color effectiveBackgroundColor = widget.isOutlined
        ? Colors.transparent
        : (widget.backgroundColor ?? theme.colorScheme.secondary);

    final Color effectiveTextColor = widget.textColor ??
        (widget.isOutlined ? theme.colorScheme.secondary : Colors.white);

    final Color effectiveBorderColor =
        widget.borderColor ?? theme.colorScheme.primary;

    return applyNeoBrutalism(
      shadowOffset: widget.shadowOffset,
      context: context,
      backgroundColor: effectiveBackgroundColor,
      borderColor: effectiveBorderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      isHovered: false,
      isPressed: false,
      child: Container(
        height: height,
        constraints: BoxConstraints(minWidth: minWidth),
        padding: widget.padding ??
            (widget.type == NeoBadgeType.dot
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 8)),
        child: _buildBadgeContent(context, fontSize, effectiveTextColor),
      ),
    );
  }

  Widget _buildBadgeContent(
      BuildContext context, double fontSize, Color textColor) {
    if (widget.child != null) {
      return widget.child!;
    }

    switch (widget.type) {
      case NeoBadgeType.counter:
        return Center(
          child: Text(
            widget.count?.toString() ?? '0',
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

      case NeoBadgeType.dot:
        return const SizedBox();

      case NeoBadgeType.status:
      case NeoBadgeType.standard:
        if (widget.icon != null && widget.label != null) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.icon!,
              const SizedBox(width: 4),
              Text(
                widget.label!,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else if (widget.icon != null) {
          return Center(child: widget.icon);
        } else if (widget.label != null) {
          return Center(
            child: Text(
              widget.label!,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return const SizedBox();
        }
    }
  }
}
