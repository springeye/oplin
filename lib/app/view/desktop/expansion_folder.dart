import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/mobile/dialog.dart';
import 'package:oplin/bloc/book_bloc.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class ExpansionFolder extends StatefulWidget {
  final Widget child;
  final Widget title;

  const ExpansionFolder({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  State<ExpansionFolder> createState() => _ExpansionFolderState();
}

class _ExpansionFolderState extends State<ExpansionFolder>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _hoverAdd = false;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _heightFactor = _controller.drive(_easeInTween);
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final ExpansionTileThemeData expansionTileTheme =
        ExpansionTileTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: _handleTap,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) {
              setState(() {
                _hoverAdd = true;
              });
            },
            onExit: (event) {
              setState(() {
                _hoverAdd = false;
              });
            },
            child: Row(
              children: [
                RotationTransition(
                  turns: _iconTurns,
                  child: const Icon(Icons.expand_more),
                ),
                Icon(_isExpanded ? Icons.folder_open : Icons.folder),
                widget.title,
                const Spacer(),
                MouseRegion(
                  // cursor: SystemMouseCursors.click,
                  onEnter: (event) {
                    setState(() {
                      _hoverAdd = true;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      _hoverAdd = false;
                    });
                  },
                  child: AnimatedOpacity(
                    opacity: _hoverAdd ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: IconButton(
                        onPressed: () {
                          showCreateNotebookDialog(context, (name) {
                            BookBloc read = context.read<BookBloc>();
                            read.add(BookAdded(name: name));
                            Navigator.pop(context);
                          }, bottom: false);
                        },
                        icon: const Icon(Icons.add)),
                  ),
                ),
              ],
            ),
          ),
        ),
        ClipRect(
          child: Align(
            alignment:
                expansionTileTheme.expandedAlignment ?? Alignment.topLeft,
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed;
    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: widget.child,
      ),
    );
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
