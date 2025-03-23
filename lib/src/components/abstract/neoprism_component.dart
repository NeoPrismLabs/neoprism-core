import 'package:flutter/widgets.dart';

abstract class NeoPrismComponent extends StatefulWidget {
  final String id;

  const NeoPrismComponent({super.key, required this.id});

  String get componentType;

  @override
  State<NeoPrismComponent> createState();
}
