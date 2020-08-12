import 'package:experiments/pages/flushbar_page.dart';
import 'package:experiments/pages/inherited_widgets_page.dart';
import 'package:experiments/pages/pseudo_bloc_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Experimentos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "flushbar": (_) => FlushbarPage(),
        "pseudoBloc": (_) => PseudoBlocPage(),
        "inherited": (_) => InheritedWidgetPage(),
      },
      initialRoute: "inherited",
    );
  }
}
