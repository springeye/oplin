import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oplin/bootstrap.dart';

import 'app/build_main.dart';
import 'dependencie_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
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
