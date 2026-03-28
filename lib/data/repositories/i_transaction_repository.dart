import '../models/transaction_model.dart';

abstract class ITransactionRepository {
  Future<List<TransactionModel>> getAll(String userId, {int? limit, int? offset});
  
  Future<List<TransactionModel>> getByMonth(String userId, int year, int month);
  
  Future<TransactionModel> add({
    required String userId,
    required TransactionType type,
    required double amount,
    required String category,
    String? description,
    required DateTime date,
  });
  
  Future<void> update(TransactionModel tx);
  
  Future<void> delete(String id);
  
  Future<Map<String, double>> getCategoryTotals(String userId, int year, int month);
}
