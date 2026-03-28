import '../models/budget_model.dart';

abstract class IBudgetRepository {
  Future<List<BudgetModel>> getForMonth(String userId, int year, int month);
  
  Future<BudgetModel> upsert({
    required String userId,
    required String category,
    required double limitAmount,
    required int month,
    required int year,
  });
  
  Future<void> delete(String id);
}
