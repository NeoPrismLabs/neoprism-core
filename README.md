# NeoPrism Core

A Flutter UI toolkit featuring neobrutalism design principles with a pluggable architecture.

## Features

- Neobrutalism styled components
- Theme customization
- Plugin architecture for analytics, localization, and more

## Getting started

Add the package to your `pubspec.yaml`:

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

- `NeoButton`: A neobrutalism styled button with press animation

## Additional information

This package is in active development. See the [GitHub repository](https://github.com/NeoPrismLabs/neoprism-core) for more information.


