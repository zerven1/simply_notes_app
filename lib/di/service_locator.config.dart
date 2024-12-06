// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:simply_notes_app/bloc/note_bloc/note_bloc.dart' as _i803;
import 'package:simply_notes_app/data/data_sources/local_note_data_source.dart'
    as _i390;
import 'package:simply_notes_app/data/data_sources/local_note_data_source_impl.dart'
    as _i727;
import 'package:simply_notes_app/data/repositories/note_repository.dart'
    as _i373;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i390.LocalNoteDataSource>(
        () => _i727.LocalNoteDataSourceImpl());
    gh.factory<_i373.NoteRepository>(
        () => _i373.NoteRepository(gh<_i390.LocalNoteDataSource>()));
    gh.factory<_i803.NoteBloc>(
        () => _i803.NoteBloc(noteRepository: gh<_i373.NoteRepository>()));
    return this;
  }
}
