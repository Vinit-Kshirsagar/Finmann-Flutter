import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/service_locator.dart';
import '../../../data/models/user_model.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/transaction/transaction_bloc.dart';
import '../../blocs/transaction/transaction_event.dart';
import '../../blocs/analytics/analytics_bloc.dart';
import '../../blocs/analytics/analytics_event.dart';
import '../../blocs/budget/budget_bloc.dart';
import '../../blocs/budget/budget_event.dart';
import '../../blocs/goal/goal_bloc.dart';
import '../../blocs/goal/goal_event.dart';
import '../../widgets/nav/animated_bottom_nav.dart';
import '../auth/login_screen.dart';
import 'dashboard_tab.dart';
import '../transactions/transactions_tab.dart';
import '../goals/goals_tab.dart';
import '../analytics/analytics_tab.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<TransactionBloc>()
          ..add(LoadTransactions(widget.user.id))),
        BlocProvider(create: (_) => sl<AnalyticsBloc>()
          ..add(LoadAnalytics(widget.user.id))),
        BlocProvider(create: (_) => sl<GoalBloc>()
          ..add(LoadGoals(widget.user.id))),
        BlocProvider(create: (_) {
          final now = DateTime.now();
          return sl<BudgetBloc>()..add(LoadBudgets(widget.user.id, now.year, now.month));
        }),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false);
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: _idx,
            children: [
              DashboardTab(user: widget.user),
              TransactionsTab(user: widget.user),
              GoalsTab(user: widget.user),
              AnalyticsTab(user: widget.user),
            ],
          ),
          bottomNavigationBar: AnimatedBottomNav(
            currentIndex: _idx,
            onTap: (i) => setState(() => _idx = i),
          ),
        ),
      ),
    );
  }
}
