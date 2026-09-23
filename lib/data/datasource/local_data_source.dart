import '../database/app_database.dart';

class LocalDataSource {
  final AppDatabase db;

  LocalDataSource(this.db);

  Future<List<Transaction>> getAllTransactions() => db.select(db.transactions).get();
  Future<int> insertTransaction(TransactionsCompanion entry) => db.into(db.transactions).insert(entry);
  Future<bool> updateTransaction(TransactionsCompanion entry) => db.update(db.transactions).replace(entry);
  Future<int> deleteTransaction(int id) => (db.delete(db.transactions)..where((t) => t.id.equals(id))).go();

  Future<List<Category>> getAllCategories() => db.select(db.categories).get();
  Future<int> insertCategory(CategoriesCompanion entry) => db.into(db.categories).insert(entry);
  Future<bool> updateCategory(CategoriesCompanion entry) => db.update(db.categories).replace(entry);
  Future<int> deleteCategory(int id) => (db.delete(db.categories)..where((c) => c.id.equals(id))).go();
}