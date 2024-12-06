import 'package:go_router/go_router.dart';
import 'package:simply_notes_app/ui/add_note_screen.dart';
import 'package:simply_notes_app/ui/home_screen.dart';

/// Application routing
class AppRouter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: HomeScreen.routePath,
    routes: [
      GoRoute(
        name: HomeScreen.routeName,
        path: HomeScreen.routePath,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            name: AddNoteScreen.routeName,
            path: AddNoteScreen.routePath,
            builder: (context, state) => const AddNoteScreen(),
          ),
        ],
      ),
    ],
  );
}
