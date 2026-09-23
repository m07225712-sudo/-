import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../datasource/local_data_source.dart';
import '../datasource/preference_datasource.dart';

class AppRepository {
  final LocalDataSource localDataSource;
  final PreferenceDataSource preferenceDataSource;

  AppRepository({
    required this.localDataSource,
    required this.preferenceDataSource,
  });

  // Transactions
  Future<List<Transaction>> fetchTransactions() => localDataSource.getAllTransactions();
  Future<List<Transaction>> getTransactions() => localDataSource.getAllTransactions();

  Future<int> addTransaction(String title, double amount, int categoryId, String description) {
    final entry = TransactionsCompanion.insert(
      amount: amount,
      category: description,
      date: DateTime.now(),
      type: 'expense',
      comment: Value(title),
    );
    return localDataSource.insertTransaction(entry);
  }

  Future<bool> updateTransaction(Transaction item) =>
      localDataSource.updateTransaction(item.toCompanion(true));

  Future<int> deleteTransaction(int id) => localDataSource.deleteTransaction(id);

  // Categories
  Future<List<Category>> fetchCategories() => localDataSource.getAllCategories();
  Future<List<Category>> getCategories() => localDataSource.getAllCategories();

  Future<int> addCategory(String name, String icon) {
    final entry = CategoriesCompanion.insert(
      name: name,
      icon: Value(icon.isEmpty ? '📁' : icon),
    );
    return localDataSource.insertCategory(entry);
  }

  Future<bool> updateCategory(Category category) =>
      localDataSource.updateCategory(category.toCompanion(true));

  Future<int> deleteCategory(int id) => localDataSource.deleteCategory(id);

  // User Settings
  Future<Map<String, dynamic>> loadUserSettings() async {
    final settings = await preferenceDataSource.getSettings();
    return settings.map((key, value) => MapEntry(key, value));
  }

  Future<void> saveUserSettings(String name, String currency) async {
    await preferenceDataSource.saveSettings(name, currency);
  }
}