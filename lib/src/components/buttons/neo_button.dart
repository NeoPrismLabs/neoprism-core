import 'package:flutter/material.dart';
import '../abstract/neoprism_component.dart';
import '../abstract/neoprism_state.dart';

class NeoButton extends NeoPrismComponent {
  final String label;

  final VoidCallback? onPressed;

  final Color? backgroundColor;

  final Color? textColor;

  final Color? borderColor;

  final EdgeInsetsGeometry padding;

  final bool isEnabled;

  const NeoButton({
    required super.id,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    this.isEnabled = true,
    super.key,
  });

  @override
  String get componentType => 'NeoButton';

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends NeoprismComponentState<NeoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: widget.isEnabled
          ? (_) {
              setState(() => _isPressed = true);
            }
          : null,
      onTapUp: widget.isEnabled
          ? (_) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
              trackInteraction('pressed');
            }
          : null,
      onTapCancel: widget.isEnabled
          ? () {
              setState(() => _isPressed = false);
            }
          : null,
      child: applyNeoBrutalism(
        context: context,
        isPressed: _isPressed,
        backgroundColor: widget.isEnabled
            ? (widget.backgroundColor ?? theme.colorScheme.primary)
            : Colors.grey.shade300,
        borderColor: widget.borderColor,
        child: Padding(
          padding: widget.padding,
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isEnabled
                  ? (widget.textColor ?? theme.colorScheme.onPrimary)
                  : Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
