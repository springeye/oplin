import 'package:flutter/material.dart';

typedef TargetChildBuilder = Function(BuildContext context, bool hover);

class TargetCard<T extends Object, D extends Object> extends StatelessWidget {
  final TargetChildBuilder builder;
  final T target;
  final Function(T target, D data) callback;
  final Color? color;

  const TargetCard({
    super.key,
    this.color,
    required this.builder,
    required this.target,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<D>(
      onWillAccept: (data) {
        return data != null;
      },
      onAccept: (data) {
        callback(target, data);
      },
      onLeave: (data) {},
      builder: (context, candidateData, rejectedData) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0),
          child: Card(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: candidateData.isEmpty
                  ? BorderSide.none
                  : BorderSide(color: Theme.of(context).primaryColor, width: 3),
            ),
            elevation: 0.0,
            child: builder(context, candidateData.isNotEmpty),
          ),
        );
      },
    );
  }
}
