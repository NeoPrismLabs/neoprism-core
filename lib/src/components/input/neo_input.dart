import 'package:flutter/material.dart';
import 'package:neoprism_core/src/components/abstract/neoprism_component.dart';
import 'package:neoprism_core/src/components/abstract/neoprism_state.dart';

enum NeoInputSize {
  small,
  medium,
  large,
}

class NeoInput extends NeoPrismComponent {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final InputDecoration? decoration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final FocusNode? focusNode;
  final NeoInputSize size;
  final bool autofocus;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enabled;

  const NeoInput({
    required super.id,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.focusNode,
    this.size = NeoInputSize.medium,
    this.autofocus = false,
    this.textStyle,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.contentPadding,
    this.enabled,
    super.key,
  });

  @override
  String get componentType => 'NeoInput';

  @override
  State<NeoInput> createState() => _NeoInputState();
}

class _NeoInputState extends NeoprismComponentState<NeoInput> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);

    _errorText = widget.errorText;
  }

  @override
  void didUpdateWidget(covariant NeoInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      setState(() {
        _errorText = widget.errorText;
      });
    }
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (_focusNode.hasFocus) {
      trackInteraction('focused');
    }
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neoTheme = getThemeData(context);

    double fontSize;
    double verticalPadding;
    double horizontalPadding;
    double iconSize;

    switch (widget.size) {
      case NeoInputSize.small:
        fontSize = 14.0;
        verticalPadding = 8.0;
        horizontalPadding = 12.0;
        iconSize = 18.0;
        break;
      case NeoInputSize.large:
        fontSize = 18.0;
        verticalPadding = 16.0;
        horizontalPadding = 20.0;
        iconSize = 24.0;
        break;
      case NeoInputSize.medium:
        fontSize = 16.0;
        verticalPadding = 12.0;
        horizontalPadding = 16.0;
        iconSize = 20.0;
    }

    final effectiveBackgroundColor =
        widget.backgroundColor ?? theme.colorScheme.surface;

    final effectiveBorderColor =
        widget.borderColor ?? (_errorText != null ? Colors.red : Colors.black);

    final effectiveTextColor =
        widget.textColor ?? theme.textTheme.bodyLarge?.color ?? Colors.black;

    final effectiveTextStyle = widget.textStyle?.copyWith(
          fontSize: fontSize,
          color: effectiveTextColor,
        ) ??
        TextStyle(
          fontSize: fontSize,
          color: effectiveTextColor,
        );

    final effectiveContentPadding = widget.contentPadding ??
        EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        );

    return MouseRegion(
      cursor: SystemMouseCursors.text,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.labelText != null) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.labelText!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
          applyNeoBrutalism(
            shadowOffset: Offset(0, 0),
            context: context,
            isHovered: _isHovered,
            isPressed: false,
            backgroundColor: effectiveBackgroundColor,
            borderColor: effectiveBorderColor,
            borderWidth: _isFocused ? neoTheme.borderWidth + 1 : null,
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              style: effectiveTextStyle,
              autofocus: widget.autofocus,
              textInputAction: widget.textInputAction,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              enabled: widget.enabled,
              decoration:
                  (widget.decoration ?? const InputDecoration()).copyWith(
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon != null
                    ? IconTheme(
                        data: IconThemeData(
                          size: iconSize,
                          color: effectiveTextColor.withOpacity(0.7),
                        ),
                        child: widget.prefixIcon!,
                      )
                    : null,
                suffixIcon: widget.suffixIcon != null
                    ? IconTheme(
                        data: IconThemeData(
                          size: iconSize,
                          color: effectiveTextColor.withOpacity(0.7),
                        ),
                        child: widget.suffixIcon!,
                      )
                    : null,
                contentPadding: effectiveContentPadding,
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorText: null,
              ),
              onChanged: (value) {
                if (widget.validator != null) {
                  setState(() {
                    _errorText = widget.validator!(value);
                  });
                }
                widget.onChanged?.call(value);
              },
              validator: widget.validator,
            ),
          ),
          if (_errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              _errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: fontSize - 2,
              ),
            ),
          ],
          if (_errorText == null && widget.helperText != null) ...[
            const SizedBox(height: 6),
            Text(
              widget.helperText!,
              style: TextStyle(
                color: theme.hintColor,
                fontSize: fontSize - 2,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
