import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../db/models.dart';
import '../../../../../l10n/S.dart';

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
            color: Theme.of(context).primaryColor,
          ),
          Text(text)
        ],
      ),
    ),
  );
}

void showMoveToFolderDialog(
  BuildContext context, {
  required List<Notebook> notebooks,
  Function? onCreatePressed,
  Function(Notebook? notebook)? onNotebookPressed,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 420,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                S.of(context).select_notebook,
                style: Theme.of(context).textTheme.headline6,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1 / 1.5,
                    ),
                    itemCount: notebooks.length + 2,
                    itemBuilder: (BuildContext context, int idx) {
                      int index = idx;
                      if (index == 0) {
                        return _cardButton(context, onPressed: () {
                          onCreatePressed?.call();
                        },
                            icon: Icons.create_new_folder,
                            text: S.of(context).create);
                      }
                      if (index == 1) {
                        return _cardButton(context, onPressed: () {
                          onNotebookPressed?.call(null);
                        }, icon: Icons.folder, text: S.of(context).unfiled);
                      }
                      index = index - 2;
                      var notebook = notebooks[index];
                      return _cardButton(context, onPressed: () {
                        onNotebookPressed?.call(notebook);
                      }, icon: Icons.folder, text: notebook.name);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showCreateNotebookDialog(
  BuildContext context,
  Function(String name) onOk,
) {
  var container = TextEditingController();
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 220,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                S.of(context).create_notebook,
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: container,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
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
                      child: Text(S.of(context).cancel),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onOk(container.text);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30)),
                      child: Text(S.of(context).ok),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

showLoading(BuildContext context) {
  showDialog(
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
