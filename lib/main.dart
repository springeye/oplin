import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:oplin/bootstrap.dart';

import 'app/build_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => App(
        child: Builder(builder: (context) {
          return buildMainWindow(context);
        }),
      ));
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = Size(1280, 720);
      win.minSize = initialSize;
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Oplin Notebook";
      win.show();
    });
  }
}
