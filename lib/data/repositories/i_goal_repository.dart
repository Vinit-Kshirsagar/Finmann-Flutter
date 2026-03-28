import '../models/goal_model.dart';

abstract class IGoalRepository {
  Future<List<GoalModel>> getAll(String userId);
  
  Future<GoalModel> create({
    required String userId,
    required String name,
    required String emoji,
    required double targetAmount,
    DateTime? deadline,
  });
  
  Future<void> addSavings(String goalId, double amount);
  
  Future<void> delete(String id);
}
