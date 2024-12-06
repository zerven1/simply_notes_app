import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:simply_notes_app/data/models/note/note.dart';
import 'package:simply_notes_app/data/repositories/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

@Injectable()
class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc({required this.noteRepository})
      : super(const NoteState(status: NoteStatus.initial, notes: [])) {
    on<AddNote>(_addNote);
    on<GetNotesList>(_getNotesList);
  }

  /// Add note to database using [NoteRepository]
  Future<void> _addNote(AddNote event, Emitter<NoteState> emit) async {
    emit(state.copyWith(status: NoteStatus.adding));

    final result = await noteRepository.addNote(event.note);

    if (result.error != null) {
      emit(
        state.copyWith(
          status: NoteStatus.error,
          errorMessage: result.error.toString(),
        ),
      );
    } else {
      emit(
        state.copyWith(status: NoteStatus.added),
      );
    }
  }

  /// Get notes list from database by [NoteRepository]
  Future<void> _getNotesList(
      GetNotesList event, Emitter<NoteState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading));

    final result = await noteRepository.getNotesList();

    if (result.error != null) {
      emit(
        state.copyWith(
          status: NoteStatus.error,
          errorMessage: result.error.toString(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: NoteStatus.success,
          notes: result.data,
        ),
      );
    }
  }
}
