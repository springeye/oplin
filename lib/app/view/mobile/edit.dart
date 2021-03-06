import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:oplin/common/toolbar.dart';
import 'package:oplin/bloc/note_bloc.dart';

import '../../../db/models.dart';
import 'package:oplin/gen/S.dart';

class EditNoteWidget extends StatefulWidget {
  final Note? note;

  const EditNoteWidget({Key? key, this.note}) : super(key: key);

  @override
  State<EditNoteWidget> createState() => _EditNoteWidgetState();
}

class _EditNoteWidgetState extends State<EditNoteWidget> {
  late final QuillController _controller;
  late final TextEditingController _titleController;
  final focusNode = FocusNode();

  @override
  void initState() {
    var title = widget.note?.title;
    var content2 = widget.note?.content;
    if (content2 != null) {
      _controller = QuillController(
          document: content2,
          selection: const TextSelection.collapsed(offset: 0));
    } else {
      _controller = QuillController.basic();
    }
    if (title != null) {
      _titleController = TextEditingController(text: title);
    } else {
      _titleController = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "create",
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.note == null
              ? S.of(context).create_note
              : S.of(context).update_note),
          actions: [
            IconButton(
                onPressed: () async {
                  var logic = context.read<NoteBloc>();
                  var content = _controller.document;
                  var title = _titleController.text;
                  if (widget.note != null) {
                    logic.add(NotesUpdated(
                        uuid: widget.note!.uuid,
                        title: title,
                        content: content));
                  } else {
                    String? notebookId;
                    var book = context.read<NoteBloc>().state.filter.notebook;
                    if (book != null && !book.isOther && !book.isRecycled) {
                      notebookId = book.uuid;
                    }
                    logic.add(
                      NotesUpdated(
                        title: title,
                        content: content,
                        notebookId: notebookId,
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            children: [
              TextField(
                controller: _titleController,
              ),
              Expanded(
                child: QuillEditor(
                  controller: _controller,
                  scrollController: ScrollController(),
                  scrollable: true,
                  focusNode: focusNode,
                  autoFocus: widget.note == null,
                  readOnly: false,
                  expands: true,
                  padding: EdgeInsets.zero,
                ),
              ),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom != 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextToolbar(
                    controller: _controller,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
