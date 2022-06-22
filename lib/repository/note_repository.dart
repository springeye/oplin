import 'package:oplin/db/models.dart';

/// {@template api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class NoteRepository {
  /// {@macro api}
  const NoteRepository();

  /// Provides a [Stream] of all notes.
  List<Note> getNotes();

  Note? findNote(String uuid);

  List<Note> findNotes(List<String> uuid);

  /// Saves a [note].
  ///
  /// If a [note] with the same id already exists, it will be replaced.
  void saveNote(Note note);

  void batchSaveNote(List<Note> notes);

  /// Deletes the note with the given id.
  ///
  /// If no note with the given id exists, a [NoteNotFoundException] error is
  /// thrown.
  void deleteNote(String uuids, {bool physics = false});

  void batchDeleteNote(List<String> uuids, {bool physics = false});
}

class NoteNotFoundException implements Exception {}
