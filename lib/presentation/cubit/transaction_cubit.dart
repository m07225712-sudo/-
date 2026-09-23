import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/database/app_database.dart';
import '../../data/repository/app_repository.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final AppRepository repository;

  TransactionCubit(this.repository) : super(TransactionInitial());

  Future<void> loadTransactions() async {
    emit(TransactionLoading());
    try {
      final transactions = await repository.fetchTransactions();
      final settings = await repository.loadUserSettings();

      emit(
        TransactionLoaded(
          transactions: transactions,
          userName: settings['name'] ?? 'Urmat',
          currency: settings['currency'] ?? 'сом',
        ),
      );
    } catch (e) {
      emit(TransactionError('Не удалось загрузить операции'));
    }
  }

  Future<void> addTransaction(String title, double amount, int categoryId, String description) async {
    try {
      await repository.addTransaction(title, amount, categoryId, description);
      await loadTransactions();
    } catch (e) {
      emit(TransactionError('Не удалось добавить расход'));
    }
  }

  Future<void> updateTransaction(Transaction item) async {
    try {
      await repository.updateTransaction(item);
      await loadTransactions();
    } catch (e) {
      emit(TransactionError('Не удалось обновить расход'));
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      await repository.deleteTransaction(id);
      await loadTransactions();
    } catch (e) {
      emit(TransactionError('Не удалось удалить расход'));
    }
  }

  Future<void> updateSettings(String name, String currency) async {
    await repository.saveUserSettings(name, currency);
    await loadTransactions();
  }
}
