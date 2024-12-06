import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simply_notes_app/bloc/note_bloc/note_bloc.dart';
import 'package:simply_notes_app/ui/add_note_screen.dart';
import 'package:simply_notes_app/ui/components/note_list_tile.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homeScreen";
  static const String routePath = "/";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// create [NoteBloc] variable for state management
  late NoteBloc noteBloc;

  @override
  initState() {
    super.initState();

    /// Set noteBloc value
    noteBloc = BlocProvider.of<NoteBloc>(context);

    /// fetching notes list from database
    noteBloc.add(GetNotesList());
  }

  /// go to add note screen method
  goToAddNoteScreen() {
    context.pushNamed(
      AddNoteScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => goToAddNoteScreen(),
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Notes",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.black26,
          ),
          body: Builder(
            builder: (context) {
              if (state.status == NoteStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status == NoteStatus.success) {
                if (state.notes.isEmpty) {
                  return const Center(
                    child: Text("No notes available."),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      final note = state.notes[index];
                      return NoteListTile(note: note);
                    },
                  ),
                );
              } else if (state.status == NoteStatus.error) {
                return Center(
                  child: Text("An error occurred: ${state.errorMessage}"),
                );
              } else {
                return const Center(
                  child: Text("No data available."),
                );
              }
            },
          ),
        );
      },
    );
  }
}
