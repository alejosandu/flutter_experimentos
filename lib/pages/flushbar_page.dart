import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarPage extends StatelessWidget {
  BuildContext context;

  _showFlushBar() {
    Flushbar(
      title: "Hola mundo",
      message: "test",
      duration: Duration(seconds: 5),
    )..show(context);
  }

  _showCustomOverlayRoute() {
    Navigator.of(context, rootNavigator: false).push(CustomRoute());
  }

  _showCustomPageRoute() {
    Navigator.of(context, rootNavigator: false).push(
      CustomPageRoute(
        builder: (context) => CustomCall(),
      ),
    );
  }

  _showCustomPageRouteBuilder() {
    Navigator.of(context, rootNavigator: false).push(
      CustomPageRouteBuilder.createRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(child: Text("Flushbar")),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text("Flushbar"),
              onPressed: _showFlushBar,
            ),
            RaisedButton(
              child: Text("Custom OverlayRoute"),
              onPressed: _showCustomOverlayRoute,
            ),
            RaisedButton(
              child: Text("Custom PageRoute"),
              onPressed: _showCustomPageRoute,
            ),
            RaisedButton(
              child: Text("Custom PageRouteBuilder"),
              onPressed: _showCustomPageRouteBuilder,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRoute extends OverlayRoute {
  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    final List<OverlayEntry> overlays = [];

    overlays.add(
      OverlayEntry(
        builder: (_) => CustomCall(),
        maintainState: false,
        opaque: false,
      ),
    );

    return overlays;
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  CustomPageRoute({
    this.builder,
  });

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    animation,
    secondaryAnimation,
  ) {
    final Widget widget = builder(context);
    return widget;
  }

  @override
  bool get maintainState => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return theme.buildTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }
}

class CustomPageRouteBuilder {
  static Route createRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => CustomCall(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class CustomCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);
    });
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.85),
        width: 50,
        height: 50,
        color: Colors.black,
        child: Center(child: Text("Works!")),
      ),
    );
  }
}
