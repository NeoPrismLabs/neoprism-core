# NeoPrism Core

A Flutter UI toolkit featuring neobrutalism design principles with a pluggable architecture.

## Features

- Neobrutalism styled components
- Theme customization
- Interactive animations
- Plugin architecture for analytics, localization, and more

## Getting started

Add the package to your pubspec.yaml:

```yaml
dependencies:
  neoprism_core: ^0.0.1
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:neoprism_core/neoprism_core.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          const NeoPrismThemeData(
            borderWidth: 4.0,
            borderRadius: 8.0,
            shadowOffset: Offset(4, 4),
          ),
        ],
      ),
      home: Scaffold(
        body: Center(
          child: NeoButton(
            id: 'my_button',
            label: 'Click Me',
            onPressed: () {},
          ),
        ),
      ),
    ),
  );
}
```

## Components

### NeoButton

A neobrutalism styled button with hover and press animations.

```dart
NeoButton(
  id: 'primary_button',
  label: 'Standard Button',
  onPressed: () {},
  backgroundColor: Colors.pink,  // Optional: customize colors
)
```

#### Button Variants

```dart
// Icon button
NeoButton.icon(
  id: 'save_button',
  icon: Icons.save,
  label: 'Save',
  onPressed: () {},
)

// Compressed button
NeoButton.compressed(
  id: 'compact_button',
  label: 'Compact',
  onPressed: () {},
)

// Small button
NeoButton.small(
  id: 'small_button',
  label: 'Small',
  onPressed: () {},
)

// Large button
NeoButton.large(
  id: 'large_button',
  label: 'Large',
  onPressed: () {},
)

// Custom button
NeoButton.custom(
  id: 'custom_button',
  onPressed: () {},
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, color: Colors.white),
      SizedBox(width: 8),
      Text('Custom Button'),
    ],
  ),
)
```

### NeoBadge

Badges for status indicators, counters, and more.

```dart
// Standard badge
NeoBadge(
  id: 'standard_badge',
  label: 'New',
  backgroundColor: Colors.blue,
)

// Status badge
NeoBadge.status(
  id: 'status_badge',
  label: 'Active',
  backgroundColor: Colors.green,
)

// Counter badge
NeoBadge.counter(
  id: 'notification_badge',
  count: 5,
  backgroundColor: Colors.red,
)

// Dot badge
NeoBadge.dot(
  id: 'dot_badge',
  backgroundColor: Colors.orange,
)
```

#### Badge Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | `String` | Unique identifier for the badge |
| `label` | `String?` | Text to display in the badge |
| `icon` | `Widget?` | Icon to display in the badge |
| `backgroundColor` | `Color?` | Background color |
| `textColor` | `Color?` | Text color |
| `borderColor` | `Color?` | Border color |
| `size` | `NeoBadgeSize` | Size of the badge (small, medium, large) |
| `isOutlined` | `bool` | Whether to use an outlined style |
| `shadowOffset` | `Offset?` | Custom shadow offset (defaults to Offset.zero) |

## Theming

NeoPrism can be themed using the `NeoPrismThemeData` class:

```dart
MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: [
      const NeoPrismThemeData(
        borderWidth: 3.0,        // Width of component borders
        borderRadius: 12.0,      // Radius of component corners
        shadowOffset: Offset(5, 5), // Offset of the neobrutalism shadow
        buttonTextStyle: TextStyle( // Default text style for buttons
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ],
  ),
)
```

### Theme Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `borderWidth` | `double` | `3.0` | Width of component borders |
| `borderRadius` | `double` | `8.0` | Radius of component corners |
| `shadowOffset` | `Offset` | `Offset(3, 3)` | Offset of the component shadow |
| `buttonTextStyle` | `TextStyle?` | `null` | Default text style for buttons |


### NeoInput

Text input field with neobrutalism styling.

```dart
NeoInput(
  id: 'email_field',
  labelText: 'Email Address',
  hintText: 'Enter your email',
  prefixIcon: Icon(Icons.email),
  onChanged: (value) => print('New value: $value'),
)
```

#### Input Variants

```dart
// Password field
NeoInput(
  id: 'password',
  labelText: 'Password',
  obscureText: true,
  suffixIcon: Icon(Icons.visibility),
)

// Multiline text area
NeoInput(
  id: 'message',
  labelText: 'Message',
  maxLines: 4,
  hintText: 'Enter your message here',
)

// Different sizes
NeoInput(
  id: 'small_input',
  labelText: 'Small Input',
  size: NeoInputSize.small,
)
```

#### Input Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | `String` | Unique identifier for the input |
| `controller` | `TextEditingController?` | Controller for the text field |
| `labelText` | `String?` | Label displayed above the input |
| `hintText` | `String?` | Placeholder text when empty |
| `helperText` | `String?` | Helper text below the input |
| `errorText` | `String?` | Error message to display |
| `onChanged` | `ValueChanged<String>?` | Callback when text changes |
| `validator` | `FormFieldValidator<String>?` | Function to validate input |
| `obscureText` | `bool` | Whether to hide text (for passwords) |
| `keyboardType` | `TextInputType` | Keyboard type for mobile input |
| `prefixIcon` | `Widget?` | Icon shown before text |
| `suffixIcon` | `Widget?` | Icon shown after text |
| `backgroundColor` | `Color?` | Background color |
| `borderColor` | `Color?` | Border color |
| `textColor` | `Color?` | Text color |
| `size` | `NeoInputSize` | Size of the input (small, medium, large) |

### NeoCheckbox

Checkbox component with neobrutalism styling.

```dart
NeoCheckbox(
  id: 'terms_checkbox',
  value: _acceptTerms,
  onChanged: (value) => setState(() => _acceptTerms = value),
  label: 'I accept the terms and conditions',
)
```

#### Checkbox Variants

```dart
// Custom colored checkbox
NeoCheckbox(
  id: 'remember_me',
  value: _rememberMe,
  onChanged: (value) => setState(() => _rememberMe = value),
  label: 'Remember me',
  activeColor: Colors.green,
)

// Disabled checkbox
NeoCheckbox(
  id: 'premium_feature',
  value: false,
  onChanged: null,
  label: 'Premium Feature (Unavailable)',
  enabled: false,
)

// Label on left side
NeoCheckbox(
  id: 'agree_checkbox',
  value: _agreeToTerms,
  onChanged: (value) => setState(() => _agreeToTerms = value),
  label: 'Agree to terms',
  labelOnLeft: true,
)

// Different sizes
NeoCheckbox(
  id: 'large_checkbox',
  value: _isSelected,
  onChanged: (value) => setState(() => _isSelected = value),
  label: 'Large option',
  size: NeoCheckboxSize.large,
)

// Custom label widget
NeoCheckbox(
  id: 'newsletter',
  value: _subscribeToNewsletter,
  onChanged: (value) => setState(() => _subscribeToNewsletter = value),
  labelWidget: Row(
    children: [
      Text('Subscribe to newsletter'),
      SizedBox(width: 4),
      Icon(Icons.mail, size: 16),
    ],
  ),
)
```

#### Checkbox Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | `String` | Unique identifier for the checkbox |
| `value` | `bool` | Whether the checkbox is checked |
| `onChanged` | `ValueChanged<bool>?` | Callback when checkbox is toggled |
| `label` | `String?` | Text label for the checkbox |
| `labelWidget` | `Widget?` | Custom widget instead of text label |
| `activeColor` | `Color?` | Background color when checked |
| `checkColor` | `Color?` | Color of the check mark |
| `borderColor` | `Color?` | Border color of the checkbox |
| `size` | `NeoCheckboxSize` | Size of the checkbox (small, medium, large) |
| `enabled` | `bool` | Whether the checkbox is interactive |
| `labelOnLeft` | `bool` | Whether to position label on left side |
| `shadowOffset` | `Offset?` | Custom shadow offset for the checkbox |

## Forms

NeoPrism components work seamlessly with Flutter's form validation:

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      NeoInput(
        id: 'email',
        labelText: 'Email',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      
      NeoInput(
        id: 'password',
        labelText: 'Password',
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      
      NeoCheckbox(
        id: 'terms',
        value: _acceptTerms,
        onChanged: (value) => setState(() => _acceptTerms = value),
        label: 'I accept the terms and conditions',
      ),
      const SizedBox(height: 24),
      
      NeoButton(
        id: 'submit_button',
        label: 'Sign Up',
        onPressed: () {
          if (_formKey.currentState!.validate() && _acceptTerms) {
            // Form is valid and terms accepted
            _submitForm();
          } else if (!_acceptTerms) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please accept the terms to continue'),
              ),
            );
          }
        },
      ),
    ],
  ),
)
```

### NeoAlertDialog

A neobrutalism-styled dialog for alerts, confirmations, and user interactions.

```dart
NeoAlertDialog.show(
  context: context,
  id: 'info_dialog',
  title: 'Information',
  content: 'This is a basic neobrutalism-styled alert dialog.',
  confirmLabel: 'Got it',
);
```

#### Dialog Variants

```dart
// Confirmation dialog with two buttons
NeoAlertDialog.show(
  context: context,
  id: 'confirm_dialog',
  title: 'Confirm Action',
  content: 'Are you sure you want to delete this item?',
  confirmLabel: 'Yes, Delete',
  cancelLabel: 'Cancel',
  confirmButtonColor: Colors.red,
  onConfirm: () {
    // Handle deletion
    Navigator.of(context).pop();
  },
);

// Custom styled dialog
NeoAlertDialog.show(
  context: context,
  id: 'styled_dialog',
  title: 'Custom Style',
  content: 'This dialog has custom colors and styling.',
  confirmLabel: 'Cool!',
  backgroundColor: Colors.yellow[100],
  borderColor: Colors.deepOrange,
  borderWidth: 4.0,
  shadowOffset: const Offset(6, 6),
  confirmButtonColor: Colors.deepOrange,
);

// Dialog with custom content widget
NeoAlertDialog.show(
  context: context,
  id: 'custom_content_dialog',
  title: 'Select Options',
  contentWidget: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      NeoCheckbox(
        id: 'option_a',
        value: _optionA,
        onChanged: (value) => setState(() => _optionA = value),
        label: 'Option A',
      ),
      SizedBox(height: 8),
      NeoCheckbox(
        id: 'option_b',
        value: _optionB,
        onChanged: (value) => setState(() => _optionB = value),
        label: 'Option B',
      ),
    ],
  ),
  confirmLabel: 'Submit',
  cancelLabel: 'Cancel',
);

// Multiple action buttons
NeoAlertDialog.show(
  context: context,
  id: 'multi_action_dialog',
  title: 'Choose an Action',
  content: 'What would you like to do with this item?',
  useCompressedButtons: true,
  confirmLabel: null, // No default confirm button
  additionalButtons: [
    NeoButton.compressed(
      id: 'view_button',
      label: 'View',
      backgroundColor: Colors.blue,
      onPressed: () {
        Navigator.of(context).pop('view');
      },
    ),
    NeoButton.compressed(
      id: 'edit_button',
      label: 'Edit',
      backgroundColor: Colors.green,
      onPressed: () {
        Navigator.of(context).pop('edit');
      },
    ),
    NeoButton.compressed(
      id: 'delete_button',
      label: 'Delete',
      backgroundColor: Colors.red,
      onPressed: () {
        Navigator.of(context).pop('delete');
      },
    ),
  ],
);

// Error dialog
NeoAlertDialog.show(
  context: context,
  id: 'error_dialog',
  titleWidget: Row(
    children: [
      Icon(Icons.error_outline, color: Colors.red),
      SizedBox(width: 8),
      Text('Error', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ],
  ),
  content: 'Something went wrong. Please try again.',
  confirmLabel: 'OK',
  confirmButtonColor: Colors.red,
  confirmTextColor: Colors.white,
);
```

#### Dialog Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | `String` | Unique identifier for the dialog |
| `title` | `String?` | Dialog title text |
| `titleWidget` | `Widget?` | Custom widget to replace the title |
| `content` | `String?` | Dialog content text |
| `contentWidget` | `Widget?` | Custom widget to replace the content |
| `confirmLabel` | `String?` | Text for the confirm button (default: 'OK') |
| `cancelLabel` | `String?` | Text for the cancel button (if null, no cancel button) |
| `backgroundColor` | `Color?` | Background color of the dialog |
| `borderColor` | `Color?` | Border color of the dialog |
| `borderWidth` | `double?` | Width of the dialog border |
| `borderRadius` | `double?` | Border radius of the dialog corners |
| `shadowOffset` | `Offset?` | Shadow offset for the neobrutalism effect |
| `confirmButtonColor` | `Color?` | Background color of the confirm button |
| `cancelButtonColor` | `Color?` | Background color of the cancel button |
| `confirmTextColor` | `Color?` | Text color of the confirm button |
| `cancelTextColor` | `Color?` | Text color of the cancel button |
| `buttonBorderColor` | `Color?` | Border color for all buttons |
| `onConfirm` | `VoidCallback?` | Callback when confirm button is pressed |
| `onCancel` | `VoidCallback?` | Callback when cancel button is pressed |
| `reverseButtonOrder` | `bool` | Whether to reverse the order of buttons (default: false) |
| `useCompressedButtons` | `bool` | Whether to use compressed button style (default: false) |
| `additionalButtons` | `List<Widget>?` | Additional buttons to display |

#### Static Show Method

The `NeoAlertDialog.show()` static method provides a convenient way to display a dialog without manually creating a dialog instance. It includes an additional `barrierDismissible` parameter to control whether the dialog can be dismissed by tapping outside of it.

```dart
Future<T?> show<T>({
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
})
```

#### Advanced Dialog Usage

Dialogs can be used to create interactive workflows:

```dart
// Multi-step dialog example
void showMultiStepDialog(BuildContext context) {
  // Step 1: Show initial dialog
  NeoAlertDialog.show(
    context: context,
    id: 'step1_dialog',
    title: 'Step 1 of 3',
    content: 'This is the first step of a multi-step dialog workflow.',
    confirmLabel: 'Next',
    cancelLabel: 'Cancel',
    onConfirm: () {
      // Close current dialog
      Navigator.of(context).pop();
      
      // Step 2: Show second dialog
      NeoAlertDialog.show(
        context: context,
        id: 'step2_dialog',
        title: 'Step 2 of 3',
        content: 'Select your preferences:',
        contentWidget: NeoCheckbox(
          id: 'preference_checkbox',
          value: _preferenceEnabled,
          onChanged: (value) => setState(() => _preferenceEnabled = value),
          label: 'Enable feature',
        ),
        confirmLabel: 'Next',
        cancelLabel: 'Back',
        onConfirm: () {
          // Close current dialog
          Navigator.of(context).pop();
          
          // Step 3: Show third dialog
          NeoAlertDialog.show(
            context: context,
            id: 'step3_dialog',
            title: 'Step 3 of 3',
            content: 'Complete the process by clicking Finish.',
            confirmLabel: 'Finish',
            cancelLabel: 'Back',
            onConfirm: () {
              // Process completed
              Navigator.of(context).pop();
              
              // Show completion message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Process completed!')),
              );
            },
            onCancel: () {
              // Go back to step 2
              Navigator.of(context).pop();
              showMultiStepDialog(context);
            },
          );
        },
        onCancel: () {
          // Go back to step 1
          Navigator.of(context).pop();
          showMultiStepDialog(context);
        },
      );
    },
  );
}
```

### Combining Dialog with Other Components

NeoAlertDialog integrates seamlessly with other NeoPrism components:

```dart
// Button that shows a dialog
NeoButton(
  id: 'show_dialog_button',
  label: 'Show Settings',
  onPressed: () {
    NeoAlertDialog.show(
      context: context,
      id: 'settings_dialog',
      title: 'Settings',
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NeoInput(
            id: 'username_input',
            labelText: 'Username',
            controller: _usernameController,
          ),
          SizedBox(height: 12),
          NeoCheckbox(
            id: 'notifications_checkbox',
            value: _notificationsEnabled,
            onChanged: (value) => setState(() => _notificationsEnabled = value),
            label: 'Enable notifications',
          ),
        ],
      ),
      confirmLabel: 'Save',
      cancelLabel: 'Cancel',
      onConfirm: _saveSettings,
    );
  },
),
```

## Component Interactions

All NeoPrism components automatically track user interactions using the internal tracking system. These interactions include:

- For NeoButton:
  - `pressed` - When the button is clicked or tapped
  - `hovered` - When the mouse hovers over the button

- For NeoInput:
  - `focused` - When the input receives focus
  - `changed` - When the input value changes

- For NeoCheckbox:
  - `toggled` - When the checkbox is checked/unchecked
  - `focused` - When the checkbox receives focus


## Combining Components

NeoPrism components are designed to work together seamlessly. Here's an example of a login form:

```dart
Column(
  children: [
    Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    SizedBox(height: 24),
    
    NeoInput(
      id: 'username',
      labelText: 'Username',
      prefixIcon: Icon(Icons.person),
    ),
    SizedBox(height: 16),
    
    NeoInput(
      id: 'password',
      labelText: 'Password',
      obscureText: true,
      prefixIcon: Icon(Icons.lock),
    ),
    SizedBox(height: 16),
    
    Row(
      children: [
        NeoCheckbox(
          id: 'remember',
          value: _rememberMe,
          onChanged: (value) => setState(() => _rememberMe = value),
          label: 'Remember me',
        ),
        Spacer(),
        TextButton(
          onPressed: () {},
          child: Text('Forgot password?'),
        ),
      ],
    ),
    SizedBox(height: 24),
    
    NeoButton(
      id: 'login_button',
      label: 'Log In',
      onPressed: _handleLogin,
    ),
  ],
)
```


## Component Architecture

NeoPrism components use a consistent architecture:

1. **NeoPrismComponent**: Abstract base class for all components
2. **NeoprismComponentState**: Base state class providing shared functionality
3. **Theme Integration**: Components automatically adapt to the NeoPrismThemeData

## Additional information

This package is in active development. See the [GitHub repository](https://github.com/NeoPrismLabs/neoprism-core) for more information, examples, and to contribute to the project.