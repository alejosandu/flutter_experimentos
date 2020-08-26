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
    Navigator.of(context, rootNavigator: false).push(CustomOverlayRoute());
  }

  _showCustomTransitionRoute() {
    Navigator.of(context, rootNavigator: false).push(CustomTransitionRoute());
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

  _showDialog() async {
    print("start");
    final response = await CustomCenteredContent.dialog<String>(context);
    print("response: $response");
    print("end");
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(child: Text("Custom Flushbar")),
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
              child: Text("Custom TransitionRoute"),
              onPressed: _showCustomTransitionRoute,
            ),
            RaisedButton(
              child: Text("Custom PageRoute"),
              onPressed: _showCustomPageRoute,
            ),
            RaisedButton(
              child: Text("Custom PageRouteBuilder"),
              onPressed: _showCustomPageRouteBuilder,
            ),
            RaisedButton(
              child: Text("Custom Dialog"),
              onPressed: _showDialog,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomOverlayRoute extends OverlayRoute {
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

class CustomTransitionRoute extends TransitionRoute {
  int dismissKey = 1;

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    final List<OverlayEntry> overlays = [];

    overlays.add(
      OverlayEntry(
        builder: (_) => Dismissible(
          key: Key(dismissKey.toString()),
          onDismissed: (direction) {
            // dismissKey++;
            navigator.removeRoute(this);
          },
          direction: DismissDirection.startToEnd,
          child: FadeTransition(
            opacity: animation,
            child: CustomCall(),
          ),
        ),
        maintainState: false,
        opaque: false,
      ),
    );

    return overlays;
  }

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 250);
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

class CustomCall extends StatefulWidget {
  @override
  _CustomCallState createState() => _CustomCallState();
}

class _CustomCallState extends State<CustomCall> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration(seconds: 5), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.85,
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
        ),
        // width: 50,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 5.0,
              spreadRadius: 5.0,
            )
          ],
        ),
        child: Scaffold(
            body: Center(
                child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Works!"),
            RaisedButton(
              child: Text("OK!"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ))),
      ),
    );
  }
}

class CustomCenteredContent extends StatefulWidget {
  static Future dialog<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) => CustomCenteredContent(),
      useRootNavigator: false,
      barrierDismissible: false,
    );
  }

  @override
  _CustomCenteredContentState createState() => _CustomCenteredContentState();
}

class _CustomCenteredContentState extends State<CustomCenteredContent> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration(seconds: 5), () {
      Navigator.pop(context, "Success!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Cargando"),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }
}
