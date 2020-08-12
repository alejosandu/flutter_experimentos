import 'package:experiments/inherited_objects/custom_consumer_widget.dart';
import 'package:flutter/material.dart';
import 'package:experiments/inherited_objects/custom_notifier_model.dart';
import 'package:experiments/inherited_objects/custom_provider_widget.dart';

class InheritedWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomProvider(
      notifier: CustomChangeNotifier(),
      child: Scaffold(
        body: Center(
          child: InheritedText(),
        ),
        floatingActionButton: ButtonAction(),
      ),
    );
  }
}

class InheritedText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final int count = CustomInheritedWidget.of(context).count;
    return CustomConsumer<CustomChangeNotifier>(
      builder: (context, notifier, child) {
        return Text("Se ha presionado ${notifier.count} veces");
      },
    );
  }
}

class ButtonAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomConsumer<CustomChangeNotifier>(
      builder: (context, notifier, child) {
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            notifier.increment();
          },
        );
      },
    );
  }
}
