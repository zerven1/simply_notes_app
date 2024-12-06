part of 'note_bloc.dart';

/// Enum for managing Note status inside [NoteState]
enum NoteStatus { initial, loading, success, error, adding, added }

class NoteState extends Equatable {
  final List<Note> notes;
  final NoteStatus status;
  final String? errorMessage;

  const NoteState({
    required this.notes,
    required this.status,
    this.errorMessage,
  });

  NoteState copyWith({
    List<Note>? notes,
    NoteStatus? status,
    String? errorMessage,
  }) {
    return NoteState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [notes, status, errorMessage];
}
