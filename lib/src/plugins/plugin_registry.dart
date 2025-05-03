import 'package:neoprism_core/src/plugins/plugin.dart';

/// Central registry for all NeoPrism plugins
class NeoPrismPluginRegistry {
  NeoPrismPluginRegistry._();

  /// Access the singleton instance of the plugin registry
  factory NeoPrismPluginRegistry() => _instance;
  static final NeoPrismPluginRegistry _instance = NeoPrismPluginRegistry._();

  final Map<Type, NeoPrismPlugin> _plugins = {};

  /// Register a plugin with the system
  void registerPlugin<T extends NeoPrismPlugin>(T plugin) {
    _plugins[T] = plugin;
    plugin.initialize();
  }

  /// Retrieve a registered plugin by type
  T? getPlugin<T extends NeoPrismPlugin>() {
    return _plugins[T] as T?;
  }

  /// Remove a plugin from the registry
  void unregisterPlugin<T extends NeoPrismPlugin>() {
    final plugin = _plugins[T];
    if (plugin != null) {
      plugin.dispose();
      _plugins.remove(T);
    }
  }
}
