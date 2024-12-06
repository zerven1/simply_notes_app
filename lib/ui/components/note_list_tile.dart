import 'package:flutter/material.dart';
import 'package:simply_notes_app/data/models/note/note.dart';
import 'package:simply_notes_app/extensions/datetime_extensions.dart';

class NoteListTile extends StatelessWidget {
  final Note note;
  NoteListTile({required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Align(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(note.content),
              ),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  note.creationDate.toFormattedString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                )),
          ),
        ),
        Divider(
          indent: 20.0,
          endIndent: 20.0,
        )
      ],
    );
  }
}
