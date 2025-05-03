import 'dart:async';

/// An event in the NeoPrism system
class NeoPrismEvent {
  NeoPrismEvent(this.type, this.componentId, [this.metadata]);

  /// Type of the event
  final String type;

  /// ID of the component that triggered the event
  final String componentId;

  /// Additional data associated with the event
  final Map<String, dynamic>? metadata;
}

/// Central event bus for NeoPrism components and plugins
class NeoPrismEventBus {
  NeoPrismEventBus._();

  /// Access the singleton instance of the event bus
  factory NeoPrismEventBus() => _instance;
  static final NeoPrismEventBus _instance = NeoPrismEventBus._();

  final _controller = StreamController<NeoPrismEvent>.broadcast();

  /// Stream of events that can be listened to
  Stream<NeoPrismEvent> get events => _controller.stream;

  /// Publish an event to the bus
  void publish(NeoPrismEvent event) {
    _controller.add(event);
  }

  /// Dispose of resources
  void dispose() {
    _controller.close();
  }
}
