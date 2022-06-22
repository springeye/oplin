// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group("diff", () {
    test("diff", () async {
      var text1 = """I am the very model of a modern Major-General,
I've information vegetable, animal, and mineral,
I know the kings of England, and I quote the fights historical,
From Marathon to Waterloo, in order categorical.""";
      var text2 = """I am the very model of a cartoon individual,
My animation's comical, unusual, and whimsical,
I'm quite adept at funny gags, comedic theory I have read,
From wicked puns and stupid jokes to anvils that drop on your head.""";

      DiffMatchPatch dmp = DiffMatchPatch();
      var d = dmp.diff(text1, text2);
      dmp.diffCleanupSemantic(d);
    });
  });
}
