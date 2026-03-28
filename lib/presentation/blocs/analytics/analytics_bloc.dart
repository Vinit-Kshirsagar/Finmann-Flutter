import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../data/repositories/i_transaction_repository.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final ITransactionRepository _repo;

  AnalyticsBloc(this._repo) : super(AnalyticsInitial()) {
    on<LoadAnalytics>(_onLoad);
  }

  Future<void> _onLoad(LoadAnalytics e, Emitter<AnalyticsState> emit) async {
    emit(AnalyticsLoading());
    try {
      final txns = await _repo.getAll(e.userId);
      final now = DateTime.now();
      
      final monthTxns = txns.where((t) => t.date.year == now.year && t.date.month == now.month).toList();
      final expenses = monthTxns.where((t) => t.isExpense).toList();
      final totalExp = expenses.fold(0.0, (s, t) => s + t.amount);
      final totalInc = monthTxns.where((t) => t.isIncome).fold(0.0, (s, t) => s + t.amount);
      
      final catMap = <String, double>{};
      for (final t in expenses) {
        catMap[t.category] = (catMap[t.category] ?? 0) + t.amount;
      }
      final sortedCats = catMap.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      
      final bars = List.generate(6, (i) {
        final m = DateTime(now.year, now.month - 5 + i);
        final mTxns = txns.where((t) => t.date.year == m.year && t.date.month == m.month).toList();
        return (
          label: DateFormat('MMM').format(m),
          income: mTxns.where((t) => t.isIncome).fold(0.0, (s, t) => s + t.amount),
          expense: mTxns.where((t) => t.isExpense).fold(0.0, (s, t) => s + t.amount),
        );
      });
      
      int hs = 0;
      if (totalInc > 0) {
        final savings = ((totalInc - totalExp) / totalInc * 100).clamp(0.0, 100.0);
        final diversity = (expenses.map((ex) => ex.category).toSet().length).clamp(0, 8) / 8 * 20;
        final base = (savings * 0.8 + diversity).clamp(0.0, 100.0);
        hs = base.round();
      }
      
      emit(AnalyticsLoaded(
        currentMonthIncome: totalInc,
        currentMonthExpense: totalExp,
        categoryExpenses: sortedCats,
        sixMonthBars: bars,
        healthScore: hs,
      ));
    } catch (err) {
      emit(AnalyticsError(err.toString()));
    }
  }
}
