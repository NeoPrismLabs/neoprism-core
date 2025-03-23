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
  bool _acceptTerms = false;
  bool _rememberMe = true;
  bool _agreeToTerms = false;
  bool _importantOption = true;
  bool _subscribeToNewsletter = false;
  bool _isSelected = true;

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
        child: SingleChildScrollView(
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
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: [
                    NeoInput(
                      id: 'username',
                      labelText: 'Username',
                      hintText: 'Enter your username',
                    ),
                    NeoInput(
                      id: 'password',
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      obscureText: true,
                      suffixIcon: Icon(Icons.visibility),
                    ),
                    NeoInput(
                      id: 'email',
                      labelText: 'Email Address',
                      hintText: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    NeoInput(
                      id: 'message',
                      labelText: 'Message',
                      hintText: 'Type your message here',
                      maxLines: 3,
                      size: NeoInputSize.large,
                      backgroundColor: Colors.grey[100],
                    ),
                  ],
                ),
              ),
              Column(
                spacing: 10,
                children: [
                  Text('Checkbox Examples:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  // Basic checkbox with label
                  NeoCheckbox(
                    id: 'terms_checkbox',
                    value: _acceptTerms,
                    onChanged: (value) => setState(() => _acceptTerms = value),
                    label: 'I accept the terms and conditions',
                  ),

                  // Checkbox with custom active color
                  NeoCheckbox(
                    id: 'remember_me',
                    value: _rememberMe,
                    onChanged: (value) => setState(() => _rememberMe = value),
                    label: 'Remember me',
                    activeColor: Colors.green,
                  ),

                  // Disabled checkbox
                  NeoCheckbox(
                    id: 'premium_feature',
                    value: false,
                    onChanged: null, // null onChanged makes it disabled
                    label: 'Premium Feature (Unavailable)',
                    enabled: false,
                  ),

                  // Checkbox with label on left
                  NeoCheckbox(
                    id: 'agree_checkbox',
                    value: _agreeToTerms,
                    onChanged: (value) => setState(() => _agreeToTerms = value),
                    label: 'Agree to terms',
                    labelOnLeft: true,
                  ),

                  // Large checkbox
                  NeoCheckbox(
                    id: 'important_option',
                    value: _importantOption,
                    onChanged: (value) =>
                        setState(() => _importantOption = value),
                    label: 'Enable important feature',
                    size: NeoCheckboxSize.large,
                  ),

                  // Checkbox with custom label widget
                  NeoCheckbox(
                    id: 'newsletter',
                    value: _subscribeToNewsletter,
                    onChanged: (value) =>
                        setState(() => _subscribeToNewsletter = value),
                    labelWidget: Row(
                      children: [
                        Text('Subscribe to newsletter'),
                        SizedBox(width: 4),
                        Icon(Icons.mail, size: 16),
                      ],
                    ),
                  ),

                  // Checkbox without label
                  NeoCheckbox(
                    id: 'standalone_checkbox',
                    value: _isSelected,
                    onChanged: (value) => setState(() => _isSelected = value),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
