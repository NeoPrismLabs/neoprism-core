import 'package:flutter/material.dart';
import 'package:neoprism_core/neoprism_core.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoPrism Example',
      theme:
          ThemeData.light().copyWith(extensions: [const NeoPrismThemeData()]),
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
              // Default button
              NeoButton(
                id: 'primary_button',
                label: 'Click Me',
                onPressed: _incrementCounter,
              )
            ])));
  }
}
