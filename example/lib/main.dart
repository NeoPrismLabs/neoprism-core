import 'package:flutter/material.dart';
import 'package:neoprism_core/neoprism_core.dart';
import 'package:neoprism_example/config/theme/app_theme.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoPrism Example',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const ButtonExampleScreen(),
    );
  }
}

class ButtonExampleScreen extends StatefulWidget {
  const ButtonExampleScreen({super.key});

  @override
  State<ButtonExampleScreen> createState() => _ButtonExampleScreenState();
}

class _ButtonExampleScreenState extends State<ButtonExampleScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeoPrism Button Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            // Standard button
            NeoButton(
              id: 'primary_button',
              label: 'Standard Button',
              onPressed: () => _incrementCounter(),
            ),
            const SizedBox(height: 12),

            // Button with icon
            NeoButton.icon(
              id: 'save_button',
              icon: Icons.check,
              label: 'Icon Button',
              onPressed: () => _incrementCounter(),
            ),
            const SizedBox(height: 12),

            // Compressed button
            NeoButton.compressed(
              id: 'compact_button',
              label: 'Compact Button',
              onPressed: () => _incrementCounter(),
            ),
            const SizedBox(height: 12),

            // Small button
            NeoButton.small(
              id: 'small_button',
              label: 'Small Button',
              backgroundColor: Colors.grey[200],
              textColor: Colors.black,
              onPressed: () => _incrementCounter(),
            ),
            const SizedBox(height: 12),

            // Large button
            NeoButton.large(
              id: 'large_button',
              label: 'Large Button',
              backgroundColor: theme.colorScheme.secondary,
              onPressed: () => _incrementCounter(),
            ),
            const SizedBox(height: 12),

            // Custom button
            NeoButton.custom(
              id: 'custom_button',
              onPressed: () => _incrementCounter(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.white),
                  const SizedBox(width: 8),
                  Text('Custom Button'),
                  const SizedBox(width: 4),
                  Icon(Icons.star, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Badge Examples:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                NeoBadge(
                  id: 'basic_badge',
                  label: 'New',
                  backgroundColor: theme.colorScheme.primary,
                ),
                NeoBadge.status(
                  id: 'active_status',
                  label: 'Active',
                  backgroundColor: Colors.green[400],
                  shadowOffset: Offset(0, 0),
                ),
                NeoBadge.counter(
                  id: 'notification_counter',
                  count: 5,
                ),
                NeoBadge.dot(
                  id: 'red_dot',
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
