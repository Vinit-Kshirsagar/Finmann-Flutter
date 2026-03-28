import 'package:equatable/equatable.dart';

abstract class GoalEvent extends Equatable {
  const GoalEvent();
  @override
  List<Object?> get props => [];
}

class LoadGoals extends GoalEvent {
  final String userId;
  const LoadGoals(this.userId);
  @override
  List<Object?> get props => [userId];
}

class AddGoal extends GoalEvent {
  final String userId;
  final String name;
  final String emoji;
  final double targetAmount;
  final DateTime? deadline;

  const AddGoal({
    required this.userId,
    required this.name,
    required this.emoji,
    required this.targetAmount,
    this.deadline,
  });

  @override
  List<Object?> get props => [userId, name, emoji, targetAmount, deadline];
}

class AddGoalSavings extends GoalEvent {
  final String userId;
  final String goalId;
  final double amount;

  const AddGoalSavings({required this.userId, required this.goalId, required this.amount});

  @override
  List<Object?> get props => [userId, goalId, amount];
}

class DeleteGoal extends GoalEvent {
  final String userId;
  final String id;
  const DeleteGoal(this.userId, this.id);
  @override
  List<Object?> get props => [userId, id];
}
