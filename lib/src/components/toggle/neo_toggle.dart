/// A neobrutalism-styled toggle switch component for binary selection options.
///
/// NeoToggle provides a distinctive on/off switch with the characteristic
/// neobrutalism design language, featuring bold borders, customizable colors,
/// and interactive animations.
///
/// Example:
/// ```dart
/// NeoToggle(
///   id: 'dark_mode_toggle',
///   value: isDarkMode,
///   onChanged: (value) {
///     setState(() => isDarkMode = value);
///   },
///   label: 'Dark Mode',
/// )
/// ```

library;

import 'package:flutter/material.dart';
import '../abstract/neoprism_component.dart';
import '../abstract/neoprism_state.dart';

/// A toggle switch component that follows the NeoPrism design system
class NeoToggle extends NeoPrismComponent {
  /// Current state of the toggle (on/off)
  final bool value;

  /// Callback function when the toggle state changes
  final ValueChanged<bool>? onChanged;

  /// Text label displayed next to the toggle
  final String? label;

  /// Custom widget displayed instead of a text label
  final Widget? labelWidget;

  /// Background color when the toggle is on
  final Color? activeColor;

  /// Background color when the toggle is off
  final Color? inactiveColor;

  /// Color of the toggle thumb/knob
  final Color? thumbColor;

  /// Border color of the toggle
  final Color? borderColor;

  /// Size of the toggle, affecting its width/height
  final double size;

  /// Whether the toggle is enabled for interaction
  final bool enabled;

  /// Focus node for controlling toggle focus
  final FocusNode? focusNode;

  /// Whether the label should be positioned to the left of the toggle
  final bool labelOnLeft;

  /// Custom shadow offset for the toggle's neobrutalism effect
  final Offset? shadowOffset;

  /// Creates a NeoToggle with the specified properties.
  ///
  /// The [id] parameter is required for component tracking.
  const NeoToggle({
    required super.id,
    required this.value,
    this.onChanged,
    this.label,
    this.labelWidget,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.borderColor,
    this.size = 24.0,
    this.enabled = true,
    this.focusNode,
    this.labelOnLeft = false,
    this.shadowOffset,
    super.key,
  }) : assert(
          label != null || labelWidget != null || true,
          'Either label or labelWidget must be provided, or both can be null for a standalone toggle',
        );

  @override
  String get componentType => 'NeoToggle';

  @override
  State<NeoToggle> createState() => _NeoToggleState();
}

class _NeoToggleState extends NeoprismComponentState<NeoToggle> {
  bool _isHovered = false;
  bool _isPressed = false;
  late final FocusNode _focusNode;
  bool _isFocused = false;

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

    // Determine colors
    final Color effectiveActiveColor =
        widget.activeColor ?? theme.colorScheme.primary;
    final Color effectiveInactiveColor =
        widget.inactiveColor ?? Colors.grey.shade300;
    final Color effectiveThumbColor = widget.thumbColor ?? Colors.white;
    final Color effectiveBorderColor = widget.borderColor ?? Colors.black;

    // Build toggle switch
    final toggleWidth = widget.size * 2.0;
    final toggleHeight = widget.size * 1.2;
    final thumbSize = widget.size * 0.8;

    // Create the toggle widget
    final toggleWidget = Focus(
      focusNode: _focusNode,
      child: GestureDetector(
        onTap: widget.enabled ? _handleTap : null,
        behavior: HitTestBehavior.opaque,
        child: MouseRegion(
          cursor: widget.enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: applyNeoBrutalism(
            context: context,
            isHovered: _isHovered && widget.enabled,
            isPressed: (_isPressed || _isFocused) && widget.enabled,
            backgroundColor:
                widget.value ? effectiveActiveColor : effectiveInactiveColor,
            borderColor: effectiveBorderColor,
            child: SizedBox(
              width: toggleWidth,
              height: toggleHeight,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    left: widget.value ? toggleWidth - thumbSize - 4 : 4,
                    top: (toggleHeight - thumbSize) / 2,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration: BoxDecoration(
                        color: effectiveThumbColor,
                        borderRadius: BorderRadius.circular(thumbSize / 2),
                        border: Border.all(
                          color: effectiveBorderColor,
                          width: neoTheme.borderWidth / 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Add label if provided
    if (widget.label == null && widget.labelWidget == null) {
      return toggleWidget;
    }

    final labelContent = widget.labelWidget ??
        Text(
          widget.label!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: widget.enabled ? Colors.black : Colors.grey,
          ),
        );

    final labelPadding = const SizedBox(width: 10);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.labelOnLeft
          ? [
              labelContent,
              labelPadding,
              toggleWidget,
            ]
          : [
              toggleWidget,
              labelPadding,
              labelContent,
            ],
    );
  }
}
