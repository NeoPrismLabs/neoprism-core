/// A neobrutalism-styled dropdown component for selecting from a list of options.
///
/// NeoDropdown provides a distinctive form input for selecting a single value from multiple options,
/// featuring bold borders, custom styling, and interactive animations consistent with neobrutalism design.
///
/// Example:
/// ```dart
/// NeoDropdown<String>(
///   id: 'country_selector',
///   value: _selectedCountry,
///   items: countries.map((country) =>
///     NeoDropdownItem(value: country, label: country)
///   ).toList(),
///   onChanged: (value) => setState(() => _selectedCountry = value),
///   label: 'Select Country',
///   placeholder: 'Choose a country',
/// )
/// ```

library;

import 'package:flutter/material.dart';
import '../abstract/neoprism_component.dart';
import '../abstract/neoprism_state.dart';

/// Represents an item in the NeoDropdown
class NeoDropdownItem<T> {
  /// The value associated with this item
  final T value;

  /// The display text for this item
  final String label;

  /// Optional icon to display with the item
  final IconData? icon;

  /// Optional custom widget to display instead of a simple label
  final Widget? customWidget;

  /// Creates a NeoDropdownItem
  const NeoDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.customWidget,
  });
}

/// Defines the size variations for the NeoDropdown component
enum NeoDropdownSize {
  /// Small-sized dropdown with compact dimensions
  small,

  /// Medium-sized dropdown (default size)
  medium,

  /// Large-sized dropdown with increased dimensions
  large,
}

/// A neobrutalism-styled dropdown component for selecting from a list of options
class NeoDropdown<T> extends NeoPrismComponent {
  /// The currently selected value
  final T? value;

  /// List of items to display in the dropdown
  final List<NeoDropdownItem<T>> items;

  /// Callback fired when the selected value changes
  final ValueChanged<T?>? onChanged;

  /// Text label displayed above the dropdown
  final String? label;

  /// Placeholder text displayed when no value is selected
  final String? placeholder;

  /// Background color of the dropdown
  final Color? backgroundColor;

  /// Border color of the dropdown
  final Color? borderColor;

  /// Text color for the dropdown text
  final Color? textColor;

  /// Size of the dropdown, affecting dimensions and text size
  final NeoDropdownSize size;

  /// Custom border width for the dropdown
  final double? borderWidth;

  /// Custom border radius for the dropdown
  final double? borderRadius;

  /// Custom shadow offset for the dropdown's neobrutalism effect
  final Offset? shadowOffset;

  /// Whether the dropdown is enabled for interaction
  final bool enabled;

  /// Focus node for controlling input focus
  final FocusNode? focusNode;

  /// Custom text style for the dropdown text
  final TextStyle? textStyle;

  /// Whether to show icons in the dropdown items if available
  final bool showIcons;

  /// Icon shown on the right side of the dropdown (default: arrow_drop_down)
  final IconData? dropdownIcon;

  /// Color of the dropdown icon
  final Color? dropdownIconColor;

  /// Custom menu elevation when the dropdown is open
  final double menuElevation;

  /// Custom widget builder for each dropdown item
  final Widget Function(
          BuildContext context, NeoDropdownItem<T> item, bool isSelected)?
      itemBuilder;

  /// Custom padding for the dropdown content
  final EdgeInsetsGeometry? contentPadding;

  /// Whether to show a divider between dropdown items
  final bool showDividers;

  /// Maximum height of the dropdown menu when open
  final double? menuMaxHeight;

  /// Creates a NeoDropdown with the specified properties.
  ///
  /// The [id] parameter is required for component tracking.
  const NeoDropdown({
    required super.id,
    required this.items,
    this.value,
    this.onChanged,
    this.label,
    this.placeholder,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.size = NeoDropdownSize.medium,
    this.borderWidth,
    this.borderRadius,
    this.shadowOffset,
    this.enabled = true,
    this.focusNode,
    this.textStyle,
    this.showIcons = true,
    this.dropdownIcon,
    this.dropdownIconColor,
    this.menuElevation = 8.0,
    this.itemBuilder,
    this.contentPadding,
    this.showDividers = false,
    this.menuMaxHeight,
    super.key,
  });

  @override
  String get componentType => 'NeoDropdown';

  @override
  State<NeoDropdown<T>> createState() => _NeoDropdownState<T>();
}

class _NeoDropdownState<T> extends NeoprismComponentState<NeoDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;
  bool _isHovered = false;
  late final FocusNode _focusNode;
  bool _isFocused = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _removeDropdown();
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
    } else {
      if (_isOpen) {
        _toggleDropdown();
      }
    }
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    setState(() {
      _isOpen = !_isOpen;
    });

    if (_isOpen) {
      _focusNode.requestFocus();
      _showDropdown();
      trackInteraction('opened');
    } else {
      _removeDropdown();
      trackInteraction('closed');
    }
  }

  void _showDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _handleItemSelected(T value) {
    _toggleDropdown();
    if (widget.value != value) {
      widget.onChanged?.call(value);
      trackInteraction('selected_item');
    }
  }

  String _getDisplayText() {
    if (widget.value == null) {
      return widget.placeholder ?? 'Select an option';
    }

    for (var item in widget.items) {
      if (item.value == widget.value) {
        return item.label;
      }
    }

    return widget.placeholder ?? 'Select an option';
  }

  IconData? _getSelectedItemIcon() {
    if (widget.value == null || !widget.showIcons) {
      return null;
    }
    for (var item in widget.items) {
      if (item.value == widget.value) {
        return item.icon;
      }
    }
    return null;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            child: Material(
              elevation: widget.menuElevation,
              borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? getThemeData(context).borderRadius),
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(widget.borderRadius ??
                      getThemeData(context).borderRadius),
                  border: Border.all(
                    color: widget.borderColor ?? Colors.black,
                    width:
                        widget.borderWidth ?? getThemeData(context).borderWidth,
                  ),
                ),
                constraints: BoxConstraints(
                  maxHeight: widget.menuMaxHeight ?? 300,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    final isSelected = item.value == widget.value;

                    if (widget.itemBuilder != null) {
                      return InkWell(
                        onTap: () => _handleItemSelected(item.value),
                        child: widget.itemBuilder!(context, item, isSelected),
                      );
                    }

                    final itemWidget = ListTile(
                      onTap: () => _handleItemSelected(item.value),
                      tileColor: isSelected
                          ? (widget.backgroundColor ?? Colors.white)
                              .withAlpha(0.8 * 255 as int)
                          : null,
                      leading: widget.showIcons && item.icon != null
                          ? Icon(item.icon,
                              color: widget.textColor ?? Colors.black)
                          : null,
                      title: item.customWidget ??
                          Text(
                            item.label,
                            style: (widget.textStyle ?? TextStyle()).copyWith(
                              color: widget.textColor ?? Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                      selected: isSelected,
                    );

                    if (widget.showDividers &&
                        index < widget.items.length - 1) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          itemWidget,
                          const Divider(height: 1, thickness: 1),
                        ],
                      );
                    }

                    return itemWidget;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double fontSize;
    EdgeInsetsGeometry padding;

    switch (widget.size) {
      case NeoDropdownSize.small:
        fontSize = 14.0;
        padding = widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        break;
      case NeoDropdownSize.large:
        fontSize = 18.0;
        padding = widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
        break;
      case NeoDropdownSize.medium:
        fontSize = 16.0;
        padding = widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12);
    }

    // Determine colors
    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? Colors.white;
    final Color effectiveBorderColor = widget.borderColor ?? Colors.black;
    final Color effectiveTextColor = widget.textColor ?? Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: fontSize - 2,
                fontWeight: FontWeight.bold,
                color: widget.enabled
                    ? effectiveTextColor
                    : effectiveTextColor.withOpacity(0.6),
              ),
            ),
          ),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: Focus(
            focusNode: _focusNode,
            child: GestureDetector(
              onTap: widget.enabled ? _toggleDropdown : null,
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
                  isPressed: (_isOpen || _isFocused) && widget.enabled,
                  backgroundColor: effectiveBackgroundColor,
                  borderColor: effectiveBorderColor,
                  borderWidth: widget.borderWidth,
                  borderRadius: widget.borderRadius,
                  shadowOffset: widget.shadowOffset,
                  child: Padding(
                    padding: padding,
                    child: Row(
                      children: [
                        if (_getSelectedItemIcon() != null) ...[
                          Icon(
                            _getSelectedItemIcon(),
                            size: fontSize + 4,
                            color: effectiveTextColor,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: Text(
                            _getDisplayText(),
                            style: (widget.textStyle ??
                                    TextStyle(
                                      fontSize: fontSize,
                                      color: effectiveTextColor,
                                    ))
                                .copyWith(
                              color: widget.enabled
                                  ? effectiveTextColor
                                  : effectiveTextColor.withOpacity(0.6),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          widget.dropdownIcon ?? Icons.arrow_drop_down,
                          size: fontSize + 8,
                          color: widget.dropdownIconColor ?? effectiveTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
