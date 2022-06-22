import 'package:oplin/db/models.dart';

/// {@template api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class NoteRepository {
  /// {@macro api}
  const NoteRepository();

  /// Provides a [Stream] of all notes.
  Stream<List<Note>> getNotes();

  Future<Note?> findNote(String uuid);

  Future<List<Note>> findNotes(List<String> uuid);

  /// Saves a [note].
  ///
  /// If a [note] with the same id already exists, it will be replaced.
  Future<void> saveNote(Note note);

  Future<void> batchSaveNote(List<Note> notes);

  /// Deletes the note with the given id.
  ///
  /// If no note with the given id exists, a [NoteNotFoundException] error is
  /// thrown.
  Future<void> deleteNote(String uuids, {bool physics = false});

  Future<void> batchDeleteNote(List<String> uuids, {bool physics = false});
}

class NoteNotFoundException implements Exception {}
