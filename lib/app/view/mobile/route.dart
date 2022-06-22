import 'package:flutter/cupertino.dart';

class AppPageRoute<T> extends CupertinoPageRoute<T> {
  AppPageRoute({required super.builder, super.settings});

// @override
// Widget buildTransitions(BuildContext context, Animation<double> animation,
//     Animation<double> secondaryAnimation, Widget child) {
//   return FadeTransition(opacity: animation, child: child);
// }
}
