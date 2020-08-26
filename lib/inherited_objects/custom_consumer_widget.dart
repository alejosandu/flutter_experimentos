import 'package:experiments/inherited_objects/custom_inherited_widget.dart';
import 'package:flutter/material.dart';

class CustomConsumer<T extends ChangeNotifier> extends StatefulWidget {
  final Function builder;
  final Widget child;
  CustomConsumer({
    @required this.builder(BuildContext context, T notifier, Widget child),
    this.child,
  }) : assert(builder != null);

  @override
  _CustomConsumerState createState() => _CustomConsumerState();
}

class _CustomConsumerState extends State<CustomConsumer> {
  dynamic _notifier;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _notifier = CustomInheritedWidget.of(context).notifier;
    _notifier.addListener(() {
      setState(() {});
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _notifier, widget.child);
  }
}
