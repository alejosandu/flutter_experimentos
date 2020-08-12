import 'package:flutter/material.dart';

class CustomInheritedWidget extends InheritedWidget {
  final Widget child;
  final notifier;

  CustomInheritedWidget({
    Key key,
    this.child,
    this.notifier,
  }) : super(key: key, child: child);

  static CustomInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomInheritedWidget>();
  }

  @override
  bool updateShouldNotify(CustomInheritedWidget oldWidget) => true;
}
