import 'package:flutter/material.dart';


class DraggableCard<T extends Object> extends StatelessWidget {
  final T data;
  final Widget child;
  final bool enabled;
  final DragEndCallback? onDragEnd;
  final VoidCallback? onDragStarted;
  final Color? color;

  const DraggableCard(
      {super.key,
      this.color,
      required this.data,
      required this.child,
      required this.enabled,
      this.onDragEnd,
      this.onDragStarted});

  @override
  Widget build(BuildContext context) {
    Widget card = Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0.0,
        child: child,
      ),
    );
    if (!enabled) {
      return card;
    }
    return LongPressDraggable(
      onDragStarted: onDragStarted,
      onDragCompleted: () {
        print("onDragCompleted");
      },
      onDragEnd: onDragEnd,
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        print("onDraggableCanceled");
      },
      onDragUpdate: (details) {
        print("onDragUpdate");
      },

      // axis: Axis.vertical,
      // maxSimultaneousDrags: 1,
      feedback: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: Transform.scale(
          scale: 0.9,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: child,
          ), //拖拽的card样式
        ),
      ),

      childWhenDragging: Opacity(
        opacity: 0.2,
        child: card,
      ),
      data: data,
      child: card,
    );
  }
}
