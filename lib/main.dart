import 'package:flutter/material.dart';
import 'package:simply_notes_app/app.dart';
import 'package:simply_notes_app/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator for getIT
  await setupServiceLocator();

  // Start application
  runApp(const App());
}
