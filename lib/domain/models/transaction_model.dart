class TransactionModel {
  final int id;
  final int userId;
  final int categoryId;
  final String title;
  final double amount;
  final String description;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.amount,
    required this.description,
    required this.createdAt,
  });
}
