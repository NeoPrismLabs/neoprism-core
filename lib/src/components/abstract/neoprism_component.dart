import 'package:flutter/widgets.dart';
import 'package:neoprism_core/src/plugins/analytics/analytics_plugin.dart';
import 'package:neoprism_core/src/plugins/events/event_bus.dart';
import 'package:neoprism_core/src/plugins/plugin_registry.dart';

abstract class NeoPrismComponent extends StatefulWidget {
  const NeoPrismComponent({super.key, required this.id});
  final String id;

  String get componentType;

  void trackInteraction(String eventType, [Map<String, dynamic>? metadata]) {
    NeoPrismEventBus().publish(NeoPrismEvent(eventType, id, metadata));
    final analytics = NeoPrismPluginRegistry().getPlugin<AnalyticsPlugin>();
    if (analytics != null) {
      analytics.trackEvent(id, eventType, {
        'componentType': componentType,
        ...?metadata,
      });
    }
  }

  @override
  State<NeoPrismComponent> createState();
}
