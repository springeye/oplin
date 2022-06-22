import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:intl/intl.dart';

import '../../../../../db/models.dart';

Widget buildNoteItem(BuildContext context, Note note) {
  var content =
      Document.fromJson(jsonDecode(note.content)).toPlainText().trim();
  var title = note.title.isEmpty ? content : note.title;
  if (note.conflict != null && note.conflict!.isNotEmpty) {
    title = "$title (conflict)";
  }
  return Container(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const Divider(
          color: Colors.transparent,
          height: 5,
        ),
        //title
        Text(
          content,
          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18),
          maxLines: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            DateFormat('yyyy-MM-dd HH:mm:ss').format(note.createTime),
            style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14),
            maxLines: 1,
          ),
        )
        //content
      ],
    ),
  );
}
