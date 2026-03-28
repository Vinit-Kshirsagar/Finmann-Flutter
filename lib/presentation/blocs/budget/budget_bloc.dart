import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/i_budget_repository.dart';
import 'budget_event.dart';
import 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final IBudgetRepository _repo;

  BudgetBloc(this._repo) : super(BudgetInitial()) {
    on<LoadBudgets>(_onLoad);
    on<UpsertBudget>(_onUpsert);
    on<DeleteBudget>(_onDelete);
  }

  Future<void> _onLoad(LoadBudgets e, Emitter<BudgetState> emit) async {
    emit(BudgetLoading());
    try {
      final budgets = await _repo.getForMonth(e.userId, e.year, e.month);
      emit(BudgetLoaded(budgets));
    } catch (err) {
      emit(BudgetError(err.toString()));
    }
  }

  Future<void> _onUpsert(UpsertBudget e, Emitter<BudgetState> emit) async {
    try {
      await _repo.upsert(
        userId: e.userId,
        category: e.category,
        limitAmount: e.limitAmount,
        month: e.month,
        year: e.year,
      );
      add(LoadBudgets(e.userId, e.year, e.month));
    } catch (err) {
      emit(BudgetError(err.toString()));
    }
  }

  Future<void> _onDelete(DeleteBudget e, Emitter<BudgetState> emit) async {
    try {
      await _repo.delete(e.id);
      add(LoadBudgets(e.userId, e.year, e.month));
    } catch (err) {
      emit(BudgetError(err.toString()));
    }
  }
}
