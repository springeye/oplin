import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_cubit.dart';

const _defaultBorderColor = Color(0xFF805306);

class WindowConfig {
  static var fitWindowTitle = false;
}

final _defaultButtonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final _defaultCloseButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class DesktopWindow extends StatelessWidget {
  final Widget child;

  const DesktopWindow({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appConfig = context.watch<AppCubit>().state;
    var backgroundStartColor = appConfig.primarySwatch.shade400;
    // var backgroundEndColor = appConfig.primarySwatch.shade700;
    var backgroundEndColor = backgroundStartColor;
    return WindowBorder(
      color: _defaultBorderColor,
      width: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundStartColor, backgroundEndColor],
              stops: const [0.0, 1.0]),
        ),
        child: Column(
          children: [
            if (WindowConfig.fitWindowTitle)
              Stack(
                children: [
                  WindowTitleBarBox(
                    child: Row(
                      children: [
                        Expanded(child: MoveWindow()),
                        const WindowButtons(),
                      ],
                    ),
                  ),
                  Expanded(child: child)
                ],
              )
            else if (!WindowConfig.fitWindowTitle)
              WindowTitleBarBox(
                child: Row(
                  children: [
                    Expanded(child: MoveWindow()),
                    const WindowButtons(),
                  ],
                ),
              ),
            if (WindowConfig.fitWindowTitle == false) Expanded(child: child)
          ],
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: _defaultButtonColors),
        MaximizeWindowButton(colors: _defaultButtonColors),
        CloseWindowButton(colors: _defaultCloseButtonColors),
      ],
    );
  }
}
