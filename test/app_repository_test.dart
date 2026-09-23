import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:money_tracker/data/database/app_database.dart';
import 'package:money_tracker/data/datasource/local_data_source.dart';
import 'package:money_tracker/data/datasource/preference_datasource.dart';
import 'package:money_tracker/data/repository/app_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('repository stores user settings and category records', () async {
    final db = AppDatabase(executor: NativeDatabase.memory());
    final repository = AppRepository(
      localDataSource: LocalDataSource(db),
      preferenceDataSource: PreferenceDataSource(),
    );

    await repository.saveUserSettings('Aibek', 'USD');
    final settings = await repository.loadUserSettings();

    expect(settings['name'], 'Aibek');
    expect(settings['currency'], 'USD');

    final categoryId = await repository.addCategory('Food', '🍔');
    expect(categoryId, isNonZero);

    final categories = await repository.fetchCategories();
    expect(categories.any((category) => category.name == 'Food'), isTrue);

    await db.close();
  });
}
