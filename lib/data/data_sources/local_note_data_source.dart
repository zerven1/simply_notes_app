import 'package:simply_notes_app/data/models/note/note.dart';

/// Local database interface
/// Used abstract to give opportunity to implement other local databases in the future
abstract class LocalNoteDataSource {
  Future<List<Note>> getNotesList();

  Future<void> addNote(Note note);

  Future<void> initializeDatabase();
}
