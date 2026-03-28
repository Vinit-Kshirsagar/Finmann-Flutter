import 'package:equatable/equatable.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();
  @override
  List<Object?> get props => [];
}

class LoadBudgets extends BudgetEvent {
  final String userId;
  final int year;
  final int month;
  const LoadBudgets(this.userId, this.year, this.month);
  @override
  List<Object?> get props => [userId, year, month];
}

class UpsertBudget extends BudgetEvent {
  final String userId;
  final String category;
  final double limitAmount;
  final int year;
  final int month;

  const UpsertBudget({
    required this.userId,
    required this.category,
    required this.limitAmount,
    required this.year,
    required this.month,
  });

  @override
  List<Object?> get props => [userId, category, limitAmount, year, month];
}

class DeleteBudget extends BudgetEvent {
  final String userId;
  final String id;
  final int year;
  final int month;

  const DeleteBudget(this.userId, this.id, this.year, this.month);
  @override
  List<Object?> get props => [userId, id, year, month];
}
