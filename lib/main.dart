import 'package:flutter/material.dart';

import 'data/database/app_database.dart';
import 'data/datasource/local_data_source.dart';
import 'data/datasource/preference_datasource.dart';
import 'data/repository/app_repository.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  final localDataSource = LocalDataSource(db);
  final prefDataSource = PreferenceDataSource();
  final repository = AppRepository(
    localDataSource: localDataSource,
    preferenceDataSource: prefDataSource,
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AppRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF0B1B17),
        brightness: Brightness.dark,
      ),
      home: const MainNavigationScreen(),
    );
  }
}