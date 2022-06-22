import 'package:flutter/material.dart';

class VerticalSplitView extends StatefulWidget {
  final Widget left;
  final Widget right;

  //ratio 0.0-1.0
  final double initSize;

  //ratio 0.0-1.0
  final double minSize;

  //ratio 0.0-1.0
  final double maxSize;
  final Widget? divider;

  const VerticalSplitView(
      {Key? key,
      required this.left,
      required this.right,
      this.initSize = 0.5,
      this.minSize = 0.1,
      this.maxSize = 0.9,
      this.divider})
      : assert(initSize >= 0),
        assert(initSize <= 1.0),
        assert(minSize >= 0),
        assert(minSize <= 1.0),
        assert(maxSize >= 0),
        assert(maxSize <= 1.0),
        super(key: key);

  @override
  State<VerticalSplitView> createState() => _VerticalSplitViewState();
}

class _VerticalSplitViewState extends State<VerticalSplitView> {
  final _dividerWidth = 16.0;
  late double _ratio;
  bool hasMouse = false;

  @override
  void initState() {
    _ratio = widget.initSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio <= 1);
      assert(_ratio >= 0);
      double maxWidth = constraints.maxWidth - _dividerWidth;
      if (maxWidth != constraints.maxWidth) {
        maxWidth = constraints.maxWidth - _dividerWidth;
      }

      var width1 = _ratio * maxWidth;
      var divider = widget.divider ??
          SizedBox(
            width: _dividerWidth,
            height: constraints.maxHeight,
            child: const Icon(Icons.drag_handle),
          );

      return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: width1,
              height: double.infinity,
              child: widget.left,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: MouseRegion(
                cursor: hasMouse
                    ? SystemMouseCursors.resizeColumn
                    : MouseCursor.defer,
                onEnter: (event) {
                  setState(() {
                    hasMouse = true;
                  });
                },
                onExit: (event) {
                  setState(() {
                    hasMouse = false;
                  });
                },
                child: divider,
              ),
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  _ratio += details.delta.dx / maxWidth;
                  if (_ratio > widget.maxSize) {
                    _ratio = widget.maxSize;
                  } else if (_ratio < widget.minSize) {
                    _ratio = widget.minSize;
                  }
                });
              },
            ),
            Expanded(
              child: widget.right,
            ),
          ],
        ),
      );
    });
  }
}
