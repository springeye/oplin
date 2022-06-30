// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oplin/common/nsx.dart';

Future<void> main() async {
  group("nsx", () {
    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
    });
    test("parse", () async {
      var result =
          await NsxImport(File("henjue.nsx")).getResult(temp: "nsx_outputs");
      expect(result.notes.isNotEmpty, true);
      result.books.forEach((element) {
        print(element);
      });
      result.notes.forEach((element) {
        print(element);
      });
    });
  });
}
