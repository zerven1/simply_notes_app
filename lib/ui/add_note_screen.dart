import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simply_notes_app/bloc/note_bloc/note_bloc.dart';
import 'package:simply_notes_app/data/models/note/note.dart';

class AddNoteScreen extends StatefulWidget {
  static const String routeName = "AddNoteScreen";
  static const String routePath = "/add_note_screen";
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController controller = TextEditingController();
  late NoteBloc noteBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    noteBloc = BlocProvider.of<NoteBloc>(context);
  }

  /// Simple show error snack bar method to show handled error message
  void showErrorSnackBar(String errorMessage) {
    final snackBar = SnackBar(
      content: Center(child: Text(errorMessage)),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state.status == NoteStatus.added) {
          noteBloc.add(GetNotesList());
          context.pop();
        }
        if (state.status == NoteStatus.error) {
          showErrorSnackBar(state.errorMessage!);
        }
      },
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              centerTitle: true,
              title: const Text(
                "Add note",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              backgroundColor: Colors.black26,
              actions: [
                if (state.status != NoteStatus.adding)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Note note = Note(
                            content: controller.text,
                            creationDate: DateTime.now(),
                          );
                          noteBloc.add(AddNote(note));
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                if (state.status == NoteStatus.adding)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      minLines: 3,
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill your notes first';
                        }
                        return null;
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: "Enter your note",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
