import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:simply_notes_app/bloc/note_bloc/note_bloc.dart';
import 'package:simply_notes_app/navigation/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(Object context) {
    return BlocProvider(
      create: (context) => GetIt.instance<NoteBloc>(),
      child: MaterialApp.router(
        title: 'Simple notes app',
        routerConfig: AppRouter.appRouter,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
