/// A neobrutalism-styled card component for displaying content with distinctive bold borders and shadow effects.
///
/// NeoCard provides a container with the characteristic neobrutalism design language,
/// featuring bold borders, customizable colors, and shadow effects.
///
/// Example:
/// ```dart
/// NeoCard(
///   id: 'profile_card',
///   child: Column(
///     children: [
///       Text('User Profile'),
///       Image.network('https://example.com/avatar.jpg'),
///       Text('John Doe'),
///     ],
///   ),
/// )
/// ```

library;

import 'package:flutter/material.dart';
import '../abstract/neoprism_component.dart';
import '../abstract/neoprism_state.dart';

/// A card component that follows the NeoPrism design system
class NeoCard extends NeoPrismComponent {
  /// The primary content of the card
  final Widget child;

  /// Background color of the card
  final Color? backgroundColor;

  /// Border color of the card
  final Color? borderColor;

  /// Custom border width for the card
  final double? borderWidth;

  /// Custom border radius for the card
  final double? borderRadius;

  /// Custom shadow offset for the card
  final Offset? shadowOffset;

  /// Padding inside the card, around the child content
  final EdgeInsetsGeometry padding;

  /// The elevation of the card, affecting shadow intensity
  final double elevation;

  /// Whether the card should respond to hover interactions
  final bool interactive;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  /// Creates a NeoCard with the specified properties.
  ///
  /// The [id] parameter is required for component tracking.
  const NeoCard({
    required super.id,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.shadowOffset,
    this.padding = const EdgeInsets.all(16),
    this.elevation = 1.0,
    this.interactive = false,
    this.onTap,
    super.key,
  });

  const NeoCard.interactive({
    required String id,
    required Widget child,
    required VoidCallback onTap,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Offset? shadowOffset,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    double elevation = 1.0,
    Key? key,
  }) : this(
          id: id,
          child: child,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          borderWidth: borderWidth,
          borderRadius: borderRadius,
          shadowOffset: shadowOffset,
          padding: padding,
          elevation: elevation,
          interactive: true,
          onTap: onTap,
          key: key,
        );

  @override
  String get componentType => 'NeoCard';

  @override
  State<NeoCard> createState() => _NeoCardState();
}

class _NeoCardState extends NeoprismComponentState<NeoCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  void _handleTap() {
    if (widget.onTap == null) return;

    setState(() => _isPressed = true);
    widget.onTap?.call();
    trackInteraction('tapped');

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() => _isPressed = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.interactive && widget.onTap != null;

    Widget cardContent = applyNeoBrutalism(
      context: context,
      isHovered: _isHovered && isInteractive,
      isPressed: _isPressed && isInteractive,
      backgroundColor: widget.backgroundColor,
      borderColor: widget.borderColor,
      borderWidth: widget.borderWidth,
      borderRadius: widget.borderRadius,
      shadowOffset: widget.shadowOffset != null
          ? widget.shadowOffset! * widget.elevation
          : null,
      child: Padding(
        padding: widget.padding,
        child: widget.child,
      ),
    );

    if (isInteractive) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _handleTap,
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
