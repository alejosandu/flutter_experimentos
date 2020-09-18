import 'package:flutter/material.dart';

class AppBarProvider2 extends InheritedWidget {
  AppBarProvider2({Key key, this.child}) : super(key: key, child: child);

  final Widget child;

  static AppBarProvider2 of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppBarProvider2>();
  }

  @override
  bool updateShouldNotify(AppBarProvider2 oldWidget) {
    return true;
  }

  String _title = "";
  String get title => _title;
  void changeTitle(String title) {
    assert(title != null);
    _title = title;
  }
}

// source: https://gist.github.com/ericwindmill/f790bd2456e6489b1ab97eba246fd4c6
// https://ericwindmill.com/articles/inherited_widget/

//app state data
class AppBarState {
  String _title = "";
  String get title => _title;
  void setTitle(String title) {
    assert(title != null);
    _title = title;
  }
}

class _InheritedAppBarStateContainer extends InheritedWidget {
  // Data is your entire state.
  final _AppBarProviderState data;

  // You must pass through a child and your state.
  _InheritedAppBarStateContainer({
    Key key,
    Widget child,
    this.data,
  }) : super(key: key, child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedAppBarStateContainer oldWidget) => true;
}

class AppBarProvider extends StatefulWidget {
  // You must pass through a child.
  final Widget child;

  AppBarProvider({@required this.child}) : assert(child != null);

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static _InheritedAppBarStateContainer of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedAppBarStateContainer>();
  }

  @override
  _AppBarProviderState createState() => _AppBarProviderState();
}

class _AppBarProviderState extends State<AppBarProvider> {
  // Whichever properties you wanna pass around your app as state
  AppBarState appBarState;

  // You can (and probably will) have methods on your AppBarProvider
  // These methods are then used through our your app to change state.
  // Using setState() here tells Flutter to repaint all the
  // Widgets in the app that rely on the state you've changed.

  @override
  void initState() {
    appBarState = AppBarState();
    super.initState();
  }

  void setTitle(String title) {
    setState(() {
      appBarState.setTitle(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedAppBarStateContainer(
      data: this,
      child: widget.child,
    );
  }
}
