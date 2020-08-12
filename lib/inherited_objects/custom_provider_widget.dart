import 'package:experiments/inherited_objects/custom_inherited_widget.dart';
import 'package:flutter/material.dart';

class CustomProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T notifier;
//   final Function builder;
  CustomProvider({
    this.child,
    this.notifier,
    // this.builder(BuildContext context, T notifier, Widget child),
  });

  @override
  _CustomProviderState createState() => _CustomProviderState();
}

class _CustomProviderState extends State<CustomProvider> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
//   build(BuildContext context) {
//     return widget.builder(
//       context,
//       widget.notifier,
//       widget.child,
//     );
//   }
  build(BuildContext context) {
    return CustomInheritedWidget(
      child: widget.child,
      notifier: widget.notifier,
    );
  }
}
