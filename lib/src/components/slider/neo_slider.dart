/// A neobrutalism-styled slider component for selecting values from a continuous or discrete range.
///
/// NeoSlider provides a distinctive slider input for adjusting numeric values,
/// featuring bold borders, custom styling, and interactive animations consistent
/// with neobrutalism design principles.
///
/// Example:
/// ```dart
/// NeoSlider(
///   id: 'volume_slider',
///   value: _volume,
///   min: 0.0,
///   max: 100.0,
///   onChanged: (value) => setState(() => _volume = value),
///   label: 'Volume',
/// )
/// ```

library;

import 'package:flutter/material.dart';
import '../abstract/neoprism_component.dart';
import '../abstract/neoprism_state.dart';

/// Defines the size variations for the NeoSlider component
enum NeoSliderSize {
  /// Small-sized slider with compact dimensions
  small,

  /// Medium-sized slider (default size)
  medium,

  /// Large-sized slider with increased dimensions
  large,
}

/// A neobrutalism-styled slider component for selecting values from a range
class NeoSlider extends NeoPrismComponent {
  /// The currently selected value
  final double value;

  /// The minimum value the slider can have
  final double min;

  /// The maximum value the slider can have
  final double max;

  /// The number of discrete divisions the slider can be moved in
  final int? divisions;

  /// Callback for when the slider value changes during interaction
  final ValueChanged<double>? onChanged;

  /// Callback for when the user starts dragging the slider
  final ValueChanged<double>? onChangeStart;

  /// Callback for when the user finishes dragging the slider
  final ValueChanged<double>? onChangeEnd;

  /// Text label displayed above the slider
  final String? label;

  /// Whether to show the current value
  final bool showValue;

  /// Format function for the displayed value
  final String Function(double value)? valueFormat;

  /// Background color of the slider track
  final Color? trackColor;

  /// Color of the active portion of the slider track
  final Color? activeTrackColor;

  /// Color of the slider thumb
  final Color? thumbColor;

  /// Border color of the slider and thumb
  final Color? borderColor;

  /// Size of the slider, affecting dimensions and thickness
  final NeoSliderSize size;

  /// Custom border width for the slider components
  final double? borderWidth;

  /// Custom border radius for the slider components
  final double? borderRadius;

  /// Custom shadow offset for the slider's neobrutalism effect
  final Offset? shadowOffset;

  /// Whether the slider is enabled for interaction
  final bool enabled;

  /// Icon displayed on the slider thumb
  final IconData? thumbIcon;

  /// Custom widget to be displayed in place of the standard thumb
  final Widget? customThumb;

  /// Padding around the slider
  final EdgeInsetsGeometry padding;

  /// Whether to show tick marks for each division
  final bool showTicks;

  /// Whether to show min and max labels
  final bool showMinMaxLabels;

  /// Custom text style for the label text
  final TextStyle? labelStyle;

  /// Custom text style for the value text
  final TextStyle? valueStyle;

  /// Creates a NeoSlider with the specified properties.
  ///
  /// The [id] and [value] parameters are required.
  const NeoSlider({
    required super.id,
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.label,
    this.showValue = true,
    this.valueFormat,
    this.trackColor,
    this.activeTrackColor,
    this.thumbColor,
    this.borderColor,
    this.size = NeoSliderSize.medium,
    this.borderWidth,
    this.borderRadius,
    this.shadowOffset,
    this.enabled = true,
    this.thumbIcon,
    this.customThumb,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
    this.showTicks = false,
    this.showMinMaxLabels = false,
    this.labelStyle,
    this.valueStyle,
    super.key,
  }) : assert(min < max, 'min must be less than max');

  @override
  String get componentType => 'NeoSlider';

  @override
  State<NeoSlider> createState() => _NeoSliderState();
}

class _NeoSliderState extends NeoprismComponentState<NeoSlider> {
  bool _isDragging = false;
  // ignore: unused_field
  bool _isHovered = false;

  // Get formatted value text
  String _getFormattedValue() {
    if (widget.valueFormat != null) {
      return widget.valueFormat!(widget.value);
    }

    // If the value is a whole number, show as integer
    if (widget.value == widget.value.roundToDouble()) {
      return widget.value.toInt().toString();
    }

    // Otherwise show with 1 decimal place
    return widget.value.toStringAsFixed(1);
  }

  // Get slider track height based on size
  double _getTrackHeight() {
    switch (widget.size) {
      case NeoSliderSize.small:
        return 8.0;
      case NeoSliderSize.large:
        return 16.0;
      case NeoSliderSize.medium:
        return 12.0;
    }
  }

  // Get thumb size based on slider size
  double _getThumbSize() {
    switch (widget.size) {
      case NeoSliderSize.small:
        return 20.0;
      case NeoSliderSize.large:
        return 32.0;
      case NeoSliderSize.medium:
        return 24.0;
    }
  }

  // Custom thumb widget
  Widget _buildThumb(Color thumbColor, Color borderColor) {
    final double thumbSize = _getThumbSize();
    final double iconSize = thumbSize * 0.6;

    final Offset effectiveShadowOffset = _isDragging || !widget.enabled
        ? const Offset(1.0, 1.0)
        : (widget.shadowOffset ?? const Offset(3.0, 3.0));

    if (widget.customThumb != null) {
      return Container(
        width: thumbSize,
        height: thumbSize,
        decoration: BoxDecoration(
          color: thumbColor,
          borderRadius: BorderRadius.circular(thumbSize / 2),
          border: Border.all(
            color: widget.enabled ? borderColor : Colors.grey,
            width: widget.borderWidth ?? getThemeData(context).borderWidth,
          ),
          boxShadow: widget.enabled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: effectiveShadowOffset,
                    blurRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Center(child: widget.customThumb),
      );
    }

    return Container(
      width: thumbSize,
      height: thumbSize,
      decoration: BoxDecoration(
        color: thumbColor,
        borderRadius: BorderRadius.circular(thumbSize / 2),
        border: Border.all(
          color: widget.enabled ? borderColor : Colors.grey,
          width: widget.borderWidth ?? getThemeData(context).borderWidth,
        ),
        boxShadow: widget.enabled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: effectiveShadowOffset,
                  blurRadius: 0,
                ),
              ]
            : null,
      ),
      child: widget.thumbIcon != null
          ? Icon(
              widget.thumbIcon,
              size: iconSize,
              color: widget.enabled ? borderColor : Colors.grey,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neoTheme = getThemeData(context);

    final Color effectiveTrackColor = widget.trackColor ?? Colors.grey.shade200;
    final Color effectiveActiveTrackColor =
        widget.activeTrackColor ?? theme.colorScheme.primary;
    final Color effectiveThumbColor = widget.thumbColor ?? Colors.white;
    final Color effectiveBorderColor = widget.borderColor ?? Colors.black;

    final TextStyle effectiveLabelStyle = widget.labelStyle ??
        TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: widget.size == NeoSliderSize.small ? 14.0 : 16.0,
        );

    final TextStyle effectiveValueStyle = widget.valueStyle ??
        TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: widget.size == NeoSliderSize.small ? 14.0 : 16.0,
          color: widget.enabled ? effectiveActiveTrackColor : Colors.grey,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null || widget.showValue) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.label != null)
                Text(
                  widget.label!,
                  style: effectiveLabelStyle,
                ),
              if (widget.showValue)
                Text(
                  _getFormattedValue(),
                  style: effectiveValueStyle,
                ),
            ],
          ),
          const SizedBox(height: 6),
        ],
        Padding(
          padding: widget.padding,
          child: MouseRegion(
            cursor: widget.enabled
                ? SystemMouseCursors.click
                : SystemMouseCursors.basic,
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: _getTrackHeight(),
                activeTrackColor: widget.enabled
                    ? effectiveActiveTrackColor
                    : effectiveActiveTrackColor.withOpacity(0.5),
                inactiveTrackColor: effectiveTrackColor,
                thumbColor: effectiveThumbColor,
                overlayColor: Colors.transparent,
                thumbShape: SliderComponentShape.noThumb,
                trackShape: _NeoTrackShape(
                  borderColor:
                      widget.enabled ? effectiveBorderColor : Colors.grey,
                  borderWidth: widget.borderWidth ?? neoTheme.borderWidth,
                  borderRadius: widget.borderRadius ?? neoTheme.borderRadius,
                ),
                tickMarkShape: widget.showTicks && widget.divisions != null
                    ? _NeoTickMarkShape(
                        tickColor: effectiveBorderColor,
                        tickWidth:
                            (widget.borderWidth ?? neoTheme.borderWidth) * 0.8,
                      )
                    : SliderTickMarkShape.noTickMark,
                showValueIndicator: ShowValueIndicator.never,
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Slider(
                    value: widget.value,
                    min: widget.min,
                    max: widget.max,
                    divisions: widget.divisions,
                    onChanged: widget.enabled
                        ? (value) {
                            widget.onChanged?.call(value);
                            trackInteraction('changed');
                          }
                        : null,
                    onChangeStart: widget.enabled
                        ? (value) {
                            setState(() => _isDragging = true);
                            widget.onChangeStart?.call(value);
                            trackInteraction('drag_started');
                          }
                        : null,
                    onChangeEnd: widget.enabled
                        ? (value) {
                            setState(() => _isDragging = false);
                            widget.onChangeEnd?.call(value);
                            trackInteraction('drag_ended');
                          }
                        : null,
                  ),
                  Positioned(
                    left: _calculateThumbPosition(),
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _buildThumb(
                          effectiveThumbColor, effectiveBorderColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.showMinMaxLabels) ...[
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.valueFormat != null
                    ? widget.valueFormat!(widget.min)
                    : widget.min.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                widget.valueFormat != null
                    ? widget.valueFormat!(widget.max)
                    : widget.max.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  double _calculateThumbPosition() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return 0;

    final double trackWidth = renderBox.size.width - _getThumbSize();
    final double normalizedValue =
        (widget.value - widget.min) / (widget.max - widget.min);
    return normalizedValue * trackWidth;
  }
}

// Custom track shape with border
class _NeoTrackShape extends RoundedRectSliderTrackShape {
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  const _NeoTrackShape({
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
  });

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    // First, paint the standard track
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
    );

    // Then paint the track border
    final Canvas canvas = context.canvas;
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    // Calculate track rectangle
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackRight = trackLeft + parentBox.size.width;
    final double trackBottom = trackTop + trackHeight;

    // Draw track border with rounded corners
    final Rect trackRect =
        Rect.fromLTRB(trackLeft, trackTop, trackRight, trackBottom);
    final RRect trackRRect =
        RRect.fromRectAndRadius(trackRect, Radius.circular(borderRadius));

    canvas.drawRRect(trackRRect, borderPaint);
  }
}

class _NeoTickMarkShape extends SliderTickMarkShape {
  const _NeoTickMarkShape({
    required this.tickColor,
    required this.tickWidth,
  });
  final Color tickColor;
  final double tickWidth;

  @override
  Size getPreferredSize({
    required SliderThemeData sliderTheme,
    required bool isEnabled,
  }) {
    return Size(tickWidth, sliderTheme.trackHeight ?? 4.0);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    required bool isEnabled,
  }) {
    final Canvas canvas = context.canvas;
    final Paint tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = tickWidth;

    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final Offset tickStart = center.translate(0, -trackHeight / 2);
    final Offset tickEnd = center.translate(0, trackHeight / 2);

    canvas.drawLine(tickStart, tickEnd, tickPaint);
  }
}
