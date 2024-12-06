part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class AddNote extends NoteEvent {
  final Note note;
  const AddNote(this.note);
}

class GetNotesList extends NoteEvent {}
