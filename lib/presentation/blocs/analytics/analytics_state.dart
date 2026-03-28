import 'package:equatable/equatable.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();
  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {}
class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final double currentMonthIncome;
  final double currentMonthExpense;
  final List<MapEntry<String, double>> categoryExpenses;
  final List<({String label, double income, double expense})> sixMonthBars;
  final int healthScore;

  const AnalyticsLoaded({
    required this.currentMonthIncome,
    required this.currentMonthExpense,
    required this.categoryExpenses,
    required this.sixMonthBars,
    required this.healthScore,
  });

  @override
  List<Object?> get props => [
    currentMonthIncome,
    currentMonthExpense,
    categoryExpenses,
    sixMonthBars,
    healthScore,
  ];
}

class AnalyticsError extends AnalyticsState {
  final String message;
  const AnalyticsError(this.message);
  @override
  List<Object?> get props => [message];
}
