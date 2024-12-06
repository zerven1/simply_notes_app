import 'package:injectable/injectable.dart';
import 'package:simply_notes_app/data/data_sources/local_note_data_source.dart';
import 'package:simply_notes_app/data/models/note/note.dart';
import 'package:simply_notes_app/data/models/result/result.dart';

/// Repository for notes with implemented injectable annotation
@Injectable()
class NoteRepository {
  final LocalNoteDataSource localNoteDataSource;

  NoteRepository(this.localNoteDataSource);

  /// Get notes list from local data storage
  Future<Result<List<Note>>> getNotesList() async {
    try {
      List<Note> notesList = await localNoteDataSource.getNotesList();
      return Result.success(notesList);
    } catch (e) {
      return Result.failure("Failed to add note: ${e.toString()}");
    }
  }

  /// Add new note to local data storage
  Future<Result<void>> addNote(Note note) async {
    try {
      await localNoteDataSource.addNote(note);
      return Result.success(null);
    } catch (e) {
      return Result.failure("Failed to add note: ${e.toString()}");
    }
  }
}
