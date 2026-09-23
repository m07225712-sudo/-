import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/database/app_database.dart';
import 'data/datasource/local_data_source.dart';
import 'data/datasource/preference_datasource.dart';
import 'data/repository/app_repository.dart';
import 'presentation/routes/app_router.dart';
import 'presentation/theme/app_colors.dart';

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
  final AppRouter appRouter;

  MyApp({super.key, required this.repository}) : appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Money Tracker',
      builder: (context, child) => RepositoryProvider.value(
        value: repository,
        child: child ?? const SizedBox.shrink(),
      ),
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          surface: AppColors.surface,
        ),
      ),
      routerConfig: appRouter.config(),
    );
  }
}
