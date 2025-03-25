/// A neobrutalism-styled checkbox component with customizable appearance and behavior.
///
/// NeoCheckbox provides a visually distinctive checkbox that follows the neobrutalism
/// design language, with support for labels, different sizes, and interactive states.
///
/// Example:
/// ```dart
/// NeoCheckbox(
///   id: 'terms_checkbox',
///   value: _termsAccepted,
///   onChanged: (value) => setState(() => _termsAccepted = value),
///   label: 'I accept the terms and conditions',
/// )
/// ```

library;

import 'package:flutter/material.dart';
import 'package:neoprism_core/neoprism_core.dart';
import 'package:neoprism_core/src/components/abstract/neoprism_state.dart';

enum NeoCheckboxSize { small, medium, large }

class NeoCheckbox extends NeoPrismComponent {
  final bool value;

  final ValueChanged<bool>? onChanged;

  final String? label;

  final Widget? labelWidget;

  final Color? activeColor;

  final Color? checkColor;

  final Color? borderColor;

  final NeoCheckboxSize size;

  final bool enabled;

  final FocusNode? focusNode;

  final bool labelOnLeft;

  final Offset? shadowOffset;
  final double? borderRadius;

  const NeoCheckbox({
    required super.id,
    required this.value,
    this.onChanged,
    this.label,
    this.labelWidget,
    this.activeColor,
    this.checkColor,
    this.borderRadius,
    this.borderColor,
    this.size = NeoCheckboxSize.medium,
    this.enabled = true,
    this.focusNode,
    this.labelOnLeft = false,
    this.shadowOffset = const Offset(2, 2),
    super.key,
  }) : assert(
          label != null || labelWidget != null || true,
          'Either label or labelWidget must be provided, or both can be null for a standalone checkbox',
        );

  @override
  String get componentType => 'NeoCheckbox';

  @override
  State<NeoCheckbox> createState() => _NeoCheckboxState();
}

class _NeoCheckboxState extends NeoprismComponentState<NeoCheckbox> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (_focusNode.hasFocus) {
      trackInteraction('focused');
    }
  }

  void _handleTap() {
    if (!widget.enabled) return;

    widget.onChanged?.call(!widget.value);
    trackInteraction('toggled');
    _focusNode.requestFocus();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted && _focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neoTheme = getThemeData(context);

    double checkboxSize;
    double borderWidth;
    double fontSize;
    double iconSize;

    switch (widget.size) {
      case NeoCheckboxSize.small:
        checkboxSize = 18.0;
        borderWidth = neoTheme.borderWidth * 0.7;
        fontSize = 14.0;
        iconSize = 12.0;
        break;
      case NeoCheckboxSize.large:
        checkboxSize = 28.0;
        borderWidth = neoTheme.borderWidth * 1.2;
        fontSize = 18.0;
        iconSize = 20.0;
        break;
      case NeoCheckboxSize.medium:
        checkboxSize = 22.0;
        borderWidth = neoTheme.borderWidth;
        fontSize = 16.0;
        iconSize = 16.0;
    }

    final effectiveActiveColor =
        widget.activeColor ?? theme.colorScheme.primary;
    final effectiveCheckColor = widget.checkColor ?? Colors.white;
    final effectiveBorderColor = widget.borderColor ?? Colors.black;

    final checkboxWidget = GestureDetector(
      onTap: widget.enabled ? _handleTap : null,
      onTapDown:
          widget.enabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp:
          widget.enabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel:
          widget.enabled ? () => setState(() => _isPressed = false) : null,
      child: MouseRegion(
        cursor: widget.enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter:
            widget.enabled ? (_) => setState(() => _isHovered = true) : null,
        onExit:
            widget.enabled ? (_) => setState(() => _isHovered = false) : null,
        child: Focus(
          focusNode: _focusNode,
          child: applyNeoBrutalism(
            context: context,
            isHovered: _isHovered && widget.enabled,
            isPressed: _isPressed || (_isFocused && widget.enabled),
            backgroundColor: widget.value ? effectiveActiveColor : Colors.white,
            borderColor: effectiveBorderColor,
            borderWidth: borderWidth,
            borderRadius: widget.borderRadius,
            shadowOffset: widget.shadowOffset,
            child: SizedBox(
              width: checkboxSize,
              height: checkboxSize,
              child: widget.value
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: iconSize,
                        color: effectiveCheckColor,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );

    Widget? labelContent;
    if (widget.labelWidget != null) {
      labelContent = widget.labelWidget;
    } else if (widget.label != null) {
      labelContent = Text(
        widget.label!,
        style: TextStyle(
          fontSize: fontSize,
          color: widget.enabled ? null : theme.disabledColor,
        ),
      );
    }

    if (labelContent == null) {
      return checkboxWidget;
    }

    return GestureDetector(
      onTap: widget.enabled ? _handleTap : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.labelOnLeft
            ? [
                labelContent,
                const SizedBox(width: 8),
                checkboxWidget,
              ]
            : [
                checkboxWidget,
                const SizedBox(width: 8),
                labelContent,
              ],
      ),
    );
  }
}
