import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:simply_notes_app/data/data_sources/local_note_data_source.dart';
import 'service_locator.config.dart';

/// Create [GetIT] instance
final getIt = GetIt.instance;

@InjectableInit()
Future<void> setupServiceLocator() async {
  /// Initialize [GetIt] instance with [Injecatable]
  getIt.init();

  /// Initialize Sqflite database
  await getIt<LocalNoteDataSource>().initializeDatabase();
}
