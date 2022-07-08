import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:oplin/bloc/edit_note_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/gen/S.dart';

class NoteEditWidget extends StatefulWidget {
  const NoteEditWidget({Key? key}) : super(key: key);

  @override
  State<NoteEditWidget> createState() => _NoteEditWidgetState();
}

class _NoteEditWidgetState extends State<NoteEditWidget> {
  late TextEditingController _titleController;

  late QuillController _quillController;
  final focusNode = FocusNode();
  bool showToolbar = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant NoteEditWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    appLog.debug("_NoteEditWidgetState.didUpdateWidget");
    _titleController.dispose();
    _quillController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: BlocBuilder<NoteBloc, NoteState>(
          buildWhen: (p, c) {
            return p.note?.uuid != c.note?.uuid;
          },
          builder: (context, state) {
            var note = state.note;
            var showLogic = context.read<EditNoteBloc>();
            _titleController = TextEditingController(text: note?.title);
            if (note != null) {
              var document2 = note.content;
              _quillController = QuillController(
                  document: document2,
                  selection: const TextSelection.collapsed(offset: 0));
            } else {
              _quillController = QuillController.basic();
            }
            _quillController.changes.listen((event) {
              appLog.debug(event.toString());
              showLogic.add(UpdatedDocumentEvent(_quillController.document));
            });
            _titleController.addListener(() {
              var editCubit = context.read<EditNoteBloc>();
              editCubit.add(UpdatedTitleEvent(_titleController.text));
            });
            return Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      child: QuillToolbar.basic(
                        // showListCheck: false,
                        toolbarIconAlignment: WrapAlignment.start,
                        controller: _quillController,
                        iconTheme: QuillIconTheme(
                            iconUnselectedFillColor: Colors.grey.shade100),
                      ),
                    ),
                  Expanded(
                    // child:
                    // QuillEditor.basic(controller: quillController, readOnly: false),
                    child: QuillEditor(
                      controller: _quillController,
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
            );
          },
        ),
      ),
      floatingActionButton: _SaveButton(
        onPressed: (oldNote, title, content) {
          var id = oldNote?.uuid;
          context
              .read<NoteBloc>()
              .add(NotesUpdated(uuid: id, title: title, content: content));
          EasyLoading.showToast(S.of(context).toast_save_success);
        },
      ),
    );
    ;
  }
}

class _SaveButton extends StatefulWidget {
  final Function(Note? old, String editTitle, Document editDocument)? onPressed;

  const _SaveButton({Key? key, this.onPressed}) : super(key: key);

  @override
  State<_SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<_SaveButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditNoteBloc, EditNoteState>(
      builder: (context, state) {
        return state.changed
            ? FloatingActionButton(
                onPressed: () {
                  var note = context.read<NoteBloc>().state.note;
                  widget.onPressed
                      ?.call(note, state.editTitle, state.editDocument);
                },
                child: const Icon(Icons.save),
              )
            : Container();
      },
    );
  }
}
