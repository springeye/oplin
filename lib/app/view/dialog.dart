import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:oplin/bloc/book_bloc.dart';

import '../../../../db/models.dart';
import 'package:oplin/gen/S.dart';

Widget _cardButton(BuildContext context,
    {required Function onPressed,
      required IconData icon,
      required String text}) {
  return GestureDetector(
    onTap: () {
      onPressed();
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 100,
            color: Theme
                .of(context)
                .primaryColor,
          ),
          Text(text)
        ],
      ),
    ),
  );
}

void showMoveToFolderDialog(BuildContext context, {
  Function? onCreatePressed,
  Function(Book? notebook)? onNotebookPressed,
}) {
  var isDesktop = Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  var buildContent = BlocBuilder<BookBloc, BooksState>(
    builder: (context, state) {
      var books = state.filteredTodos.toList();
      var gridView = GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1 / 1.5,
        ),
        itemCount: books.length + 2,
        itemBuilder: (BuildContext context, int idx) {
          int index = idx;
          if (index == 0) {
            return _cardButton(context, onPressed: () {
              onCreatePressed?.call();
            }, icon: Icons.create_new_folder, text: S
                .of(context)
                .create);
          }
          if (index == 1) {
            return _cardButton(context, onPressed: () {
              onNotebookPressed?.call(null);
            }, icon: Icons.folder, text: S
                .of(context)
                .unfiled);
          }
          index = index - 2;
          var notebook = books[index];
          return _cardButton(context, onPressed: () {
            onNotebookPressed?.call(notebook);
          }, icon: Icons.folder, text: notebook.name);
        },
      );
      var listView = ListView.builder(
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          index = index;
          var notebook = books[index];

          return ListTile(
            title: Text(notebook.name), leading: Icon(Icons.folder), onTap: () {
            onNotebookPressed?.call(notebook);
          },);
        },
      );
      return Padding(
        padding: MediaQuery
            .of(context)
            .viewInsets,
        child: Container(
          height: isDesktop ? 520 : 320,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                S
                    .of(context)
                    .select_notebook,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
                  child: isDesktop ? listView : gridView,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  if (isDesktop) {
    showDialog<Widget>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              width: 550,
              child: buildContent,
            ),
          );
        });
  } else {
    showModalBottomSheet<Widget>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return buildContent;
      },
    );
  }
}

void showCreateNotebookDialog(BuildContext context,
    Function(String name) onOk) {
  var container = TextEditingController();
  var content = Padding(
    padding: MediaQuery
        .of(context)
        .viewInsets,
    child: Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            S
                .of(context)
                .create_notebook,
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: container,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme
                          .of(context)
                          .primaryColor),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(15)))),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30)),
                  child: Text(S
                      .of(context)
                      .cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    onOk(container.text);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30)),
                  child: Text(S
                      .of(context)
                      .ok),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    showDialog<Widget>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              width: 350,
              child: content,
            ),
          );
        });
  } else {
    showModalBottomSheet<Widget>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return content;
      },
    );
  }
}

void showLoading(BuildContext context) {
  showDialog<Widget>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: const UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              content: SizedBox(
                height: 100,
                width: 100,
                child:
                LoadingIndicator(indicatorType: Indicator.ballClipRotate),
              ),
            ),
          ),
        );
      });
}

void showContextMenu(BuildContext context, Offset offset, List<Widget> items) {
  double width = 150;
  showModal<Widget>(
    context: context,
    configuration: const FadeScaleTransitionConfiguration(
      barrierColor: Colors.transparent,
    ),
    builder: (context) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints.expand(
                  width: constraints.maxWidth, height: constraints.maxHeight),
              child: Stack(
                children: [
                  Positioned(
                    top: offset.dy,
                    left: offset.dx,
                    child: SizedBox(
                      width: width,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: items,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    },
  );
}
