import '../plugin.dart';

/// Plugin interface for analytics tracking
abstract class AnalyticsPlugin extends NeoPrismPlugin {
  /// Track an interaction event from a component
  void trackEvent(String componentId, String eventType,
      [Map<String, dynamic>? metadata]);

  /// Track a screen view
  void trackScreen(String screenName);
}
