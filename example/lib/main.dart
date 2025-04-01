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
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  int _counter = 0;
  bool _acceptTerms = false;
  bool _rememberMe = true;
  bool _agreeToTerms = false;
  bool _importantOption = true;
  bool _subscribeToNewsletter = false;
  bool _isSelected = true;
  Map<String, bool> _toggleValues = {};
  String? _selectedCountry;
  String? _selectedFruit;
  String? _selectedSize;
  double _volumeValue = 50.0;
  double _opacityValue = 0.7;
  double _temperatureValue = 22.5;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Color _getTemperatureColor(double temp) {
    if (temp < 20) return Colors.blue;
    if (temp < 22) return Colors.teal;
    if (temp < 24) return Colors.green;
    if (temp < 26) return Colors.orange;
    return Colors.red;
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
                width: MediaQuery.of(context).size.width / 1.5,
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
              ),
              const SizedBox(height: 32),
              Text('Alert Examples:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              NeoButton(
                id: 'show_dialog_button',
                label: 'Show Dialog',
                onPressed: () {
                  NeoAlertDialog.show(
                    context: context,
                    id: 'example_dialog',
                    title: 'Sample Dialog',
                    content:
                        'This is an example of the NeoAlertDialog component.',
                    confirmLabel: 'Cool!',
                    cancelLabel: 'Close',
                    onConfirm: () {
                      setState(() {
                        _counter += 5;
                      });
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
              const SizedBox(height: 32),
              Text('Card Examples:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Basic card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard(
                  id: 'basic_card',
                  backgroundColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Basic Card',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(
                          'This is a simple card with default styling. It demonstrates the basic neobrutalism card design.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Card with custom colors
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard(
                  id: 'colored_card',
                  backgroundColor: Colors.amber[100],
                  borderColor: Colors.amber[800],
                  borderWidth: 4,
                  elevation: 1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Custom Styled Card',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[900])),
                      SizedBox(height: 8),
                      Text(
                          'This card uses custom colors, border width, and elevation to create a unique look.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Interactive card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard.interactive(
                  id: 'interactive_card',
                  backgroundColor: theme.colorScheme.primary,
                  borderColor: Colors.black,
                  borderWidth: 2,
                  elevation: 1.5,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Interactive Card Tapped!')));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.touch_app, color: Colors.black),
                      SizedBox(width: 12),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Interactive Card',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(
                                'Tap this card to trigger an action. Interactive cards can be used for navigation or selection.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 32),
              Text('Toggle Examples:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Basic toggles in a card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard(
                  id: 'basic_toggles',
                  backgroundColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Basic Toggles',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),

                      // Basic toggle with default styling
                      NeoToggle(
                        id: 'toggle_basic',
                        value: _toggleValues['basic'] ?? false,
                        onChanged: (value) {
                          setState(() {
                            _toggleValues['basic'] = value;
                          });
                        },
                        label: 'Default Toggle',
                      ),
                      SizedBox(height: 12),

                      // Disabled toggle
                      NeoToggle(
                        id: 'toggle_disabled',
                        value: true,
                        onChanged: null,
                        enabled: false,
                        label: 'Disabled Toggle',
                      ),
                      SizedBox(height: 12),

                      // Toggle with label on left
                      NeoToggle(
                        id: 'toggle_left_label',
                        value: _toggleValues['leftLabel'] ?? true,
                        onChanged: (value) {
                          setState(() {
                            _toggleValues['leftLabel'] = value;
                          });
                        },
                        label: 'Label on Left',
                        labelOnLeft: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Styled toggles
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard(
                  id: 'styled_toggles',
                  backgroundColor: Colors.grey[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Custom Styled Toggles',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),

                      // Custom colors
                      NeoToggle(
                        id: 'toggle_custom_colors',
                        value: _toggleValues['customColors'] ?? true,
                        onChanged: (value) {
                          setState(() {
                            _toggleValues['customColors'] = value;
                          });
                        },
                        label: 'Custom Colors',
                        activeColor: Colors.green,
                        inactiveColor: Colors.red[100],
                        borderColor: Colors.black87,
                      ),
                      SizedBox(height: 12),

                      // Larger size
                      NeoToggle(
                        id: 'toggle_large',
                        value: _toggleValues['large'] ?? false,
                        onChanged: (value) {
                          setState(() {
                            _toggleValues['large'] = value;
                          });
                        },
                        label: 'Large Toggle',
                        size: 36.0,
                        activeColor: Colors.purple,
                        thumbColor: Colors.yellow,
                      ),
                      SizedBox(height: 12),

                      // Custom thumb and border
                      NeoToggle(
                        id: 'toggle_custom_thumb',
                        value: _toggleValues['customThumb'] ?? false,
                        onChanged: (value) {
                          setState(() {
                            _toggleValues['customThumb'] = value;
                          });
                        },
                        label: 'Custom Thumb Style',
                        activeColor: Colors.blue[800],
                        thumbColor: Colors.orange[300],
                        borderColor: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Toggle with widget label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard(
                  id: 'advanced_toggles',
                  backgroundColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Advanced Usage',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),

                      // Toggle with widget label
                      NeoToggle(
                        id: 'toggle_widget_label',
                        value: _toggleValues['widgetLabel'] ?? false,
                        onChanged: (value) {
                          setState(() {
                            _toggleValues['widgetLabel'] = value;
                          });
                        },
                        labelWidget: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.dark_mode,
                              color: Colors.indigo,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Dark Theme',
                              style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        activeColor: Colors.indigo,
                        inactiveColor: const Color.fromARGB(255, 140, 150, 207),
                      ),
                      SizedBox(height: 12),

                      // Toggle in a settings-like layout
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Notifications',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Text(
                                'Enable notifications to stay updated',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          NeoToggle(
                            id: 'toggle_notifications',
                            value: _toggleValues['notifications'] ?? true,
                            onChanged: (value) {
                              setState(() {
                                _toggleValues['notifications'] = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Dropdown Examples:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Basic dropdowns in a card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard(
                  id: 'basic_dropdowns',
                  backgroundColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Basic Dropdowns',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),

                      // Basic dropdown
                      NeoDropdown<String>(
                        id: 'country_dropdown',
                        value: _selectedCountry,
                        items: [
                          NeoDropdownItem(value: 'us', label: 'United States'),
                          NeoDropdownItem(value: 'ca', label: 'Canada'),
                          NeoDropdownItem(value: 'uk', label: 'United Kingdom'),
                          NeoDropdownItem(value: 'au', label: 'Australia'),
                          NeoDropdownItem(value: 'jp', label: 'Japan'),
                          NeoDropdownItem(value: 'de', label: 'Germany'),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedCountry = value);
                        },
                        label: 'Select Country',
                        placeholder: 'Choose a country',
                      ),
                      SizedBox(height: 16),

                      // Dropdown with icons
                      NeoDropdown<String>(
                        id: 'fruit_dropdown',
                        value: _selectedFruit,
                        items: [
                          NeoDropdownItem(
                              value: 'apple',
                              label: 'Apple',
                              icon: Icons.apple),
                          NeoDropdownItem(
                              value: 'banana',
                              label: 'Banana',
                              icon: Icons.emoji_food_beverage),
                          NeoDropdownItem(
                              value: 'orange',
                              label: 'Orange',
                              icon: Icons.circle),
                          NeoDropdownItem(
                              value: 'grape',
                              label: 'Grape',
                              icon: Icons.bubble_chart),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedFruit = value);
                        },
                        label: 'Select Fruit',
                        placeholder: 'Choose a fruit',
                        showIcons: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Styled dropdowns
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard(
                  id: 'styled_dropdowns',
                  backgroundColor: Colors.grey[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Custom Styled Dropdowns',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),

                      // Dropdown with custom styling
                      NeoDropdown<String>(
                        id: 'size_dropdown',
                        value: _selectedSize,
                        items: [
                          NeoDropdownItem(value: 'xs', label: 'Extra Small'),
                          NeoDropdownItem(value: 's', label: 'Small'),
                          NeoDropdownItem(value: 'm', label: 'Medium'),
                          NeoDropdownItem(value: 'l', label: 'Large'),
                          NeoDropdownItem(value: 'xl', label: 'Extra Large'),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedSize = value);
                        },
                        label: 'Select Size',
                        placeholder: 'Choose a size',
                        backgroundColor: Colors.blue[50],
                        borderColor: Colors.blue[800],
                        textColor: Colors.blue[900],
                        dropdownIcon: Icons.arrow_drop_down_circle,
                        dropdownIconColor: Colors.blue[800],
                        borderWidth: 3,
                        showDividers: true,
                        size: NeoDropdownSize.large,
                      ),

                      // Disabled dropdown
                      SizedBox(height: 16),
                      NeoDropdown<String>(
                        id: 'disabled_dropdown',
                        value: 'disabled',
                        items: [
                          NeoDropdownItem(
                              value: 'disabled', label: 'Disabled Dropdown'),
                        ],
                        onChanged: null,
                        enabled: false,
                        label: 'Disabled Dropdown',
                        placeholder: 'This dropdown is disabled',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Then add this example section
              const SizedBox(height: 32),
              Text('Slider Examples:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Basic sliders in a card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard(
                  id: 'basic_sliders',
                  backgroundColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Basic Sliders',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),

                      // Basic slider
                      NeoSlider(
                        id: 'volume_slider',
                        value: _volumeValue,
                        min: 0,
                        max: 100,
                        onChanged: (value) {
                          setState(() => _volumeValue = value);
                        },
                        label: 'Volume',
                        valueFormat: (value) => '${value.round()}%',
                      ),
                      SizedBox(height: 20),

                      // Discrete slider with divisions
                      NeoSlider(
                        id: 'opacity_slider',
                        value: _opacityValue,
                        min: 0,
                        max: 1,
                        divisions: 10,
                        onChanged: (value) {
                          setState(() => _opacityValue = value);
                        },
                        label: 'Opacity',
                        valueFormat: (value) => '${(value * 100).round()}%',
                        showMinMaxLabels: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Styled sliders
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NeoCard(
                  id: 'styled_sliders',
                  backgroundColor: Colors.grey[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Custom Styled Sliders',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),

                      // Custom color slider
                      NeoSlider(
                        id: 'temperature_slider',
                        value: _temperatureValue,
                        min: 16,
                        max: 30,
                        divisions: 14,
                        onChanged: (value) {
                          setState(() => _temperatureValue = value);
                        },
                        label: 'Temperature',
                        valueFormat: (value) => '${value.toStringAsFixed(1)}°C',
                        activeTrackColor:
                            _getTemperatureColor(_temperatureValue),
                        trackColor: Colors.grey[200],
                        thumbColor: Colors.white,
                        size: NeoSliderSize.large,
                        showMinMaxLabels: true,
                        showTicks: true,
                      ),
                      SizedBox(height: 20),

                      // Disabled slider
                      NeoSlider(
                        id: 'disabled_slider',
                        value: 35,
                        min: 0,
                        max: 100,
                        label: 'Disabled Slider',
                        enabled: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
