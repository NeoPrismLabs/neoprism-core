import 'package:flutter/material.dart';

abstract class NeoPrismPlugin {
  /// Unique identifier for the plugin
  String get pluginId;

  /// Called when the plugin is registered
  @mustCallSuper
  void initialize() {
    debugPrint('Plugin $pluginId initialized');
  }

  /// Called when the plugin is being removed or the app is shutting down
  @mustCallSuper
  void dispose() {
    debugPrint('Plugin $pluginId disposed');
  }
}
