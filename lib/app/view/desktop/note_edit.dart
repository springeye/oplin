
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:oplin/bloc/show_node_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/gen/S.dart';

class NoteEditWidget extends StatefulWidget {
  const NoteEditWidget({Key? key}) : super(key: key);

  @override
  State<NoteEditWidget> createState() => _NoteEditWidgetState();
}

class _NoteEditWidgetState extends State<NoteEditWidget> {
  TextEditingController? _titleController;

  QuillController? _quillController;
  final focusNode = FocusNode();
  bool showToolbar = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController?.dispose();
    _quillController?.dispose();
    focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowNodeBloc, ShowNodeState>(
      builder: (context, state) {
        var note=state.note;
        var showLogic = context.read<ShowNodeBloc>();
        _titleController?.dispose();
        _quillController?.dispose();
        _titleController = TextEditingController(text: note?.title);
        if (note != null) {
          var document2 = note.content;
          _quillController = QuillController(
              document: document2,
              selection: const TextSelection.collapsed(offset: 0));
        } else {
          _quillController = QuillController.basic();
        }
        _quillController!.changes.listen((event) {
          appLog.debug(event.toString());
          showLogic.add(UpdatedDocumentEvent(_quillController!.document));

        });
        _titleController!.addListener(() {
          var editCubit = context.read<ShowNodeBloc>();
          editCubit.add(UpdatedTitleEvent(_titleController!.text));

        });
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  TextField(
                    style: Theme.of(context).textTheme.titleLarge,
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: S.of(context).hint_enter_title,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  if (showToolbar)
                    Container(
                      color: Colors.grey.shade100,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        scrollDirection: Axis.horizontal,
                        child: QuillToolbar.basic(
                          toolbarIconAlignment: WrapAlignment.start,
                          controller: _quillController!,
                          iconTheme: QuillIconTheme(
                              iconUnselectedFillColor: Colors.grey.shade100),
                        ),
                      ),
                    ),
                  Expanded(
                    // child:
                    // QuillEditor.basic(controller: quillController, readOnly: false),
                    child: QuillEditor(
                      controller: _quillController!,
                      scrollController: ScrollController(),
                      scrollable: true,
                      focusNode: focusNode,
                      autoFocus: true,
                      readOnly: false,
                      expands: true,
                      padding: const EdgeInsets.all(10),
                      keyboardAppearance: Brightness.light,
                      showCursor: true,
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: !state.changed?null:_SaveButton(
            onPressed: () {
              var oldNote = note;
              var id = oldNote?.uuid;
              var title = state.editTitle;
              var content = state.editDocument;
              context
                  .read<NoteBloc>()
                  .add(NotesUpdated(id!, title: title, content: content));
              EasyLoading.showToast(S.of(context).toast_save_success);
            },
          ),
        );
      },
    );
  }
}

class _SaveButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const _SaveButton({Key? key, this.onPressed}) : super(key: key);

  @override
  State<_SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<_SaveButton> {
  bool showSave = false;

  void show() {
    setState(() {
      showSave = true;
    });
  }

  void hide() {
    setState(() {
      showSave = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSave
          ? FloatingActionButton(
              onPressed: widget.onPressed,
              child: const Icon(Icons.save),
            )
          : null,
    );
  }
}
