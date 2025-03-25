/// A neobrutalism-styled alert dialog component for displaying messages, confirmations, or custom content.
///
/// NeoAlertDialog provides a consistent dialog experience within the neobrutalism design language,
/// featuring bold borders, customizable colors, and flexible content options.
///
/// Example:
/// ```dart
/// NeoAlertDialog.show(
///   context: context,
///   id: 'confirm_dialog',
///   title: 'Confirm Action',
///   content: 'Are you sure you want to proceed?',
///   confirmLabel: 'Yes',
///   cancelLabel: 'No',
/// )
/// ```

library;

import 'package:flutter/material.dart';
import 'package:neoprism_core/neoprism_core.dart';
import 'package:neoprism_core/src/components/abstract/neoprism_state.dart';

class NeoAlertDialog extends NeoPrismComponent {
  final String? title;
  final Widget? titleWidget;
  final String? content;
  final Widget? contentWidget;
  final String? confirmLabel;
  final String? cancelLabel;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final Offset? shadowOffset;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;
  final Color? confirmTextColor;
  final Color? cancelTextColor;
  final Color? buttonBorderColor;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool reverseButtonOrder;
  final bool useCompressedButtons;
  final List<Widget>? additionalButtons;

  const NeoAlertDialog({
    required super.id,
    this.title,
    this.titleWidget,
    this.content,
    this.contentWidget,
    this.confirmLabel = 'OK',
    this.cancelLabel,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.shadowOffset,
    this.confirmButtonColor,
    this.cancelButtonColor,
    this.confirmTextColor,
    this.cancelTextColor,
    this.buttonBorderColor,
    this.onConfirm,
    this.onCancel,
    this.reverseButtonOrder = false,
    this.useCompressedButtons = false,
    this.additionalButtons,
    super.key,
  });

  @override
  String get componentType => 'NeoAlertDialog';

  /// Show a NeoAlertDialog as a modal dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required String id,
    String? title,
    Widget? titleWidget,
    String? content,
    Widget? contentWidget,
    String confirmLabel = 'OK',
    String? cancelLabel,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Offset? shadowOffset,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    Color? confirmTextColor,
    Color? cancelTextColor,
    Color? buttonBorderColor,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
    bool reverseButtonOrder = false,
    bool useCompressedButtons = false,
    List<Widget>? additionalButtons,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return NeoAlertDialog(
          id: id,
          title: title,
          titleWidget: titleWidget,
          content: content,
          contentWidget: contentWidget,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          borderWidth: borderWidth,
          borderRadius: borderRadius,
          shadowOffset: shadowOffset,
          confirmButtonColor: confirmButtonColor,
          cancelButtonColor: cancelButtonColor,
          confirmTextColor: confirmTextColor,
          cancelTextColor: cancelTextColor,
          buttonBorderColor: buttonBorderColor,
          onConfirm: onConfirm,
          onCancel: onCancel,
          reverseButtonOrder: reverseButtonOrder,
          useCompressedButtons: useCompressedButtons,
          additionalButtons: additionalButtons,
        );
      },
    );
  }

  @override
  State<NeoPrismComponent> createState() => _NeoAlertDialogState();
}

class _NeoAlertDialogState extends NeoprismComponentState<NeoAlertDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neoTheme = getThemeData(context);

    final effectiveBgColor = widget.backgroundColor ?? Colors.white;
    final effectiveBorderColor = widget.borderColor ?? Colors.black;
    final effectiveBorderWidth = widget.borderWidth ?? neoTheme.borderWidth;
    final effectiveBorderRadius = widget.borderRadius ?? neoTheme.borderRadius;
    final effectiveShadowOffset = widget.shadowOffset ?? neoTheme.shadowOffset;

    List<Widget> dialogButtons = [];

    // Confirm button
    if (widget.confirmLabel != null) {
      final confirmButton = widget.useCompressedButtons
          ? NeoButton.compressed(
              id: '${widget.id}_confirm_button',
              label: widget.confirmLabel!,
              backgroundColor:
                  widget.confirmButtonColor ?? theme.colorScheme.primary,
              textColor: widget.confirmTextColor,
              borderColor: widget.buttonBorderColor,
              onPressed: () {
                if (widget.onConfirm != null) {
                  widget.onConfirm!();
                } else {
                  Navigator.of(context).pop(true);
                }
              },
            )
          : NeoButton(
              id: '${widget.id}_confirm_button',
              label: widget.confirmLabel!,
              backgroundColor:
                  widget.confirmButtonColor ?? theme.colorScheme.primary,
              textColor: widget.confirmTextColor,
              borderColor: widget.buttonBorderColor,
              onPressed: () {
                if (widget.onConfirm != null) {
                  widget.onConfirm!();
                } else {
                  Navigator.of(context).pop(true);
                }
              },
            );
      dialogButtons.add(Expanded(child: confirmButton));
    }

    // Cancel button
    if (widget.cancelLabel != null) {
      if (dialogButtons.isNotEmpty) {
        dialogButtons.add(const SizedBox(width: 8));
      }

      final cancelButton = widget.useCompressedButtons
          ? NeoButton.compressed(
              id: '${widget.id}_cancel_button',
              label: widget.cancelLabel!,
              backgroundColor: widget.cancelButtonColor ?? Colors.white,
              textColor: widget.cancelTextColor ?? Colors.black,
              borderColor: widget.buttonBorderColor,
              onPressed: () {
                if (widget.onCancel != null) {
                  widget.onCancel!();
                } else {
                  Navigator.of(context).pop(false);
                }
              },
            )
          : NeoButton(
              id: '${widget.id}_cancel_button',
              label: widget.cancelLabel!,
              backgroundColor: widget.cancelButtonColor ?? Colors.white,
              textColor: widget.cancelTextColor ?? Colors.black,
              borderColor: widget.buttonBorderColor,
              onPressed: () {
                if (widget.onCancel != null) {
                  widget.onCancel!();
                } else {
                  Navigator.of(context).pop(false);
                }
              },
            );
      dialogButtons.add(Expanded(child: cancelButton));
    }

    // Additional buttons
    if (widget.additionalButtons != null &&
        widget.additionalButtons!.isNotEmpty) {
      for (final button in widget.additionalButtons!) {
        if (dialogButtons.isNotEmpty) {
          dialogButtons.add(const SizedBox(width: 8));
        }
        dialogButtons.add(Expanded(child: button));
      }
    }

    // Reverse button order if specified
    if (widget.reverseButtonOrder) {
      dialogButtons = dialogButtons.reversed.toList();
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: applyNeoBrutalism(
        context: context,
        isHovered: false,
        isPressed: false,
        backgroundColor: effectiveBgColor,
        borderColor: effectiveBorderColor,
        borderWidth: effectiveBorderWidth,
        borderRadius: effectiveBorderRadius,
        shadowOffset: effectiveShadowOffset,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              if (widget.titleWidget != null)
                widget.titleWidget!
              else if (widget.title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    widget.title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              // Content
              if (widget.contentWidget != null)
                widget.contentWidget!
              else if (widget.content != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    widget.content!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

              // Buttons
              if (dialogButtons.isNotEmpty)
                Row(
                  children: dialogButtons,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
