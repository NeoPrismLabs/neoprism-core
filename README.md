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

### Component State Tracking

Each component includes built-in interaction tracking:

```dart
// Components track interactions automatically
NeoButton(
  id: 'signup_button',
  label: 'Sign Up',
  onPressed: () {},
)
```

## Additional information

This package is in active development. See the [GitHub repository](https://github.com/NeoPrismLabs/neoprism-core) for more information, examples, and to contribute to the project.