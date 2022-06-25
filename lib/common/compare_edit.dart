import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/widgets.dart';

class CompareEditWidget extends StatefulWidget {
  const CompareEditWidget({Key? key}) : super(key: key);

  @override
  State<CompareEditWidget> createState() => _CompareEditWidgetState();
}

class _CompareEditWidgetState extends State<CompareEditWidget> {
  String leftText = 'ajksdfjklasdjfkla';
  String rightText = 'ajklsjdfajklsdf';

  @override
  Widget build(BuildContext context) {
    DiffMatchPatch dmp = DiffMatchPatch();
    var d = dmp.diff(leftText, rightText);
    dmp.diffCleanupSemantic(d);
    return Row(
      children: [Text(leftText), Text(rightText)],
    );
  }
}
