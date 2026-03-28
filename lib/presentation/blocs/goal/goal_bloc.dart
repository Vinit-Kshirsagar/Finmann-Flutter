import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/i_goal_repository.dart';
import 'goal_event.dart';
import 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final IGoalRepository _repo;

  GoalBloc(this._repo) : super(GoalInitial()) {
    on<LoadGoals>(_onLoad);
    on<AddGoal>(_onAdd);
    on<AddGoalSavings>(_onAddSavings);
    on<DeleteGoal>(_onDelete);
  }

  Future<void> _onLoad(LoadGoals e, Emitter<GoalState> emit) async {
    emit(GoalLoading());
    try {
      final goals = await _repo.getAll(e.userId);
      emit(GoalLoaded(goals));
    } catch (err) {
      emit(GoalError(err.toString()));
    }
  }

  Future<void> _onAdd(AddGoal e, Emitter<GoalState> emit) async {
    try {
      await _repo.create(
        userId: e.userId,
        name: e.name,
        emoji: e.emoji,
        targetAmount: e.targetAmount,
        deadline: e.deadline,
      );
      add(LoadGoals(e.userId));
    } catch (err) {
      emit(GoalError(err.toString()));
    }
  }

  Future<void> _onAddSavings(AddGoalSavings e, Emitter<GoalState> emit) async {
    try {
      await _repo.addSavings(e.goalId, e.amount);
      add(LoadGoals(e.userId));
    } catch (err) {
      emit(GoalError(err.toString()));
    }
  }

  Future<void> _onDelete(DeleteGoal e, Emitter<GoalState> emit) async {
    try {
      await _repo.delete(e.id);
      add(LoadGoals(e.userId));
    } catch (err) {
      emit(GoalError(err.toString()));
    }
  }
}
