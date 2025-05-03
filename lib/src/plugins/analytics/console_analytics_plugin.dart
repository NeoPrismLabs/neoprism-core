import 'dart:async';

import 'package:neoprism_core/neoprism_core.dart';

/// A simple analytics plugin that logs events to the console
class ConsoleAnalyticsPlugin implements AnalyticsPlugin {
  @override
  String get pluginId => 'console_analytics';

  StreamSubscription? subscription;

  @override
  void initialize() {
    print('ConsoleAnalyticsPlugin initialized');

    subscription = NeoPrismEventBus().events.listen((event) {
      trackEvent(event.componentId, event.type, event.metadata);
    });
  }

  @override
  void dispose() {
    print('ConsoleAnalyticsPlugin disposed');
  }

  @override
  void trackEvent(String componentId, String eventType,
      [Map<String, dynamic>? metadata]) {
    print('Event: $eventType | Component: $componentId | Data: $metadata');
  }

  @override
  void trackScreen(String screenName) {
    print('Screen View: $screenName');
  }
}
