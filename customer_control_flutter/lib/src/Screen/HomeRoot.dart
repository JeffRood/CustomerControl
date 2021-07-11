
import 'package:flutter/material.dart';

class HomeRootScreen extends InheritedWidget {


  HomeRootScreen({Key? key,  required this.child})
      : super(key: key, child: child);

  final Widget child;

  static HomeRootScreen? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeRootScreen>();
  }

  @override
  bool updateShouldNotify(HomeRootScreen oldWidget) {
    return true;
  }
}
