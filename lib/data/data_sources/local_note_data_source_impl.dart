import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:simply_notes_app/data/data_sources/local_note_data_source.dart';
import 'package:simply_notes_app/data/models/note/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Local Data source implementation
@Singleton(as: LocalNoteDataSource)
class LocalNoteDataSourceImpl implements LocalNoteDataSource {
  Database? _database;

  /// Initialize database
  @override
  Future<void> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'notes.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            creationDate TEXT
          )
        ''');
      },
    );
  }

  /// Get notes list from database
  @override
  Future<List<Note>> getNotesList() async {
    if (_database == null) {
      throw Exception("Database is not initialized");
    }

    final List<Map<String, dynamic>> notesMap = await _database!.query('notes');
    return notesMap.map((map) => Note.fromJson(map)).toList();
  }

  /// Add a new note to the database
  @override
  Future<void> addNote(Note note) async {
    if (_database == null) {
      throw Exception("Database is not initialized");
    }

    await _database!.insert(
      'notes',
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
