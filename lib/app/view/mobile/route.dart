import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPageRoute<T> extends MaterialPageRoute<T> {
  AppPageRoute({required super.builder, super.settings});

// @override
// Widget buildTransitions(BuildContext context, Animation<double> animation,
//     Animation<double> secondaryAnimation, Widget child) {
//   return FadeTransition(opacity: animation, child: child);
// }
}
