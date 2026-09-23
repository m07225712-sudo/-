import '../../data/database/app_database.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final String userName;
  final String currency;

  TransactionLoaded({
    required this.transactions,
    required this.userName,
    required this.currency,
  });
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}
