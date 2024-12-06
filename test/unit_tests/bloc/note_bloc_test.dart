import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simply_notes_app/bloc/note_bloc/note_bloc.dart';
import 'package:simply_notes_app/data/models/note/note.dart';
import 'package:simply_notes_app/data/models/result/result.dart';
import 'package:simply_notes_app/data/repositories/note_repository.dart';

// Example test of NoteBloc using bloc_test and mockito
class MockNoteRepository extends Mock implements NoteRepository {}

class FakeNote extends Fake implements Note {}

void main() {
  late MockNoteRepository mockNoteRepository;
  late NoteBloc noteBloc;

  setUpAll(() {
    registerFallbackValue(FakeNote());
  });

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    noteBloc = NoteBloc(noteRepository: mockNoteRepository);
  });

  tearDown(() {
    noteBloc.close();
  });

  group('NoteBloc', () {
    test('Test NoteBloc initial state', () {
      expect(
        noteBloc.state,
        const NoteState(status: NoteStatus.initial, notes: []),
      );
    });

    blocTest<NoteBloc, NoteState>(
      'Test getNotesList function where bloc should emit loading then success',
      build: () {
        when(() => mockNoteRepository.getNotesList()).thenAnswer(
          (_) async => Result.success([
            Note(id: 1, creationDate: DateTime.now(), content: 'Note 1'),
          ]),
        );
        return noteBloc;
      },
      act: (bloc) => bloc.add(GetNotesList()),
      expect: () => [
        const NoteState(status: NoteStatus.loading, notes: []),
        isA<NoteState>()
            .having((state) => state.status, 'status', NoteStatus.success)
            .having((state) => state.notes.length, 'notes length', 1),
      ],
      verify: (_) {
        verify(() => mockNoteRepository.getNotesList()).called(1);
      },
    );

    blocTest<NoteBloc, NoteState>(
      'Test getNotesList when error is returned from repository',
      build: () {
        when(() => mockNoteRepository.getNotesList()).thenAnswer(
          (_) async => Result.failure('Error fetching notes'),
        );
        return noteBloc;
      },
      act: (bloc) => bloc.add(GetNotesList()),
      expect: () => [
        const NoteState(status: NoteStatus.loading, notes: []),
        const NoteState(
          status: NoteStatus.error,
          notes: [],
          errorMessage: 'Error fetching notes',
        ),
      ],
      verify: (_) {
        verify(() => mockNoteRepository.getNotesList()).called(1);
      },
    );

    blocTest<NoteBloc, NoteState>(
      'Test AddNote function where bloc should emit adding and added states',
      build: () {
        when(() => mockNoteRepository.addNote(any())).thenAnswer(
          (_) async => Result.success(null),
        );
        return noteBloc;
      },
      act: (bloc) => bloc.add(AddNote(
        Note(id: 2, creationDate: DateTime.now(), content: 'New Note'),
      )),
      expect: () => [
        const NoteState(status: NoteStatus.adding, notes: []),
        const NoteState(status: NoteStatus.added, notes: []),
      ],
      verify: (_) {
        verify(() => mockNoteRepository.addNote(any())).called(1);
      },
    );

    blocTest<NoteBloc, NoteState>(
      'Test when AddNote function returns error',
      build: () {
        when(() => mockNoteRepository.addNote(any())).thenAnswer(
          (_) async => Result.failure('Error adding note'),
        );
        return noteBloc;
      },
      act: (bloc) => bloc.add(AddNote(
        Note(id: 3, creationDate: DateTime.now(), content: 'Fail Note'),
      )),
      expect: () => [
        const NoteState(status: NoteStatus.adding, notes: []),
        const NoteState(
          status: NoteStatus.error,
          notes: [],
          errorMessage: 'Error adding note',
        ),
      ],
      verify: (_) {
        verify(() => mockNoteRepository.addNote(any())).called(1);
      },
    );
  });
}
