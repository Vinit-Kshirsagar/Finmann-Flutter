import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/goal_model.dart';
import '../../../data/models/user_model.dart';
import '../../blocs/goal/goal_bloc.dart';
import '../../blocs/goal/goal_event.dart';
import '../../blocs/goal/goal_state.dart';
import '../../widgets/charts/goal_ring.dart';
import 'package:finmann/shared/widgets/fm_button.dart';
import 'package:finmann/shared/widgets/fm_text_field.dart';
import 'package:finmann/shared/widgets/fm_skeleton.dart';

class GoalsTab extends StatefulWidget {
  final UserModel user;
  const GoalsTab({super.key, required this.user});

  @override
  State<GoalsTab> createState() => _GoalsTabState();
}

class _GoalsTabState extends State<GoalsTab> {
  @override
  void initState() {
    super.initState();
    // Goals are loaded by HomeScreen via BlocProvider
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings Goals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _showAddGoal(context),
          ),
        ],
      ),
      body: BlocBuilder<GoalBloc, GoalState>(
        builder: (context, state) {
          if (state is GoalLoading) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 3,
              itemBuilder: (_, i) => const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: FmSkeleton(width: double.infinity, height: 120),
              ),
            );
          } else if (state is GoalLoaded) {
            if (state.goals.isEmpty) {
              return _EmptyGoals(onAdd: () => _showAddGoal(context));
            }
            return RefreshIndicator(
              onRefresh: () async => context.read<GoalBloc>().add(LoadGoals(widget.user.id)),
              color: AppColors.primary,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ...state.goals.asMap().entries.map((e) =>
                    _GoalCard(
                      goal: e.value,
                      onAddSavings: () => _showAddSavings(context, e.value),
                      onDelete: () => context.read<GoalBloc>().add(DeleteGoal(e.value.id, widget.user.id)),
                    ).animate()
                      .fadeIn(delay: Duration(milliseconds: e.key * 80))
                      .slideY(begin: 0.06),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            );
          } else if (state is GoalError) {
            return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: AppColors.expense)));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showAddGoal(BuildContext context) {
    final nameCtrl = TextEditingController();
    final amtCtrl = TextEditingController();
    String emoji = '🎯';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cream200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => StatefulBuilder(builder: (ctx, setSt) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            left: 20, right: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4,
                decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              Text('New Goal', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 20),
              // Emoji picker row
              Row(children: ['🎯','🚗','📱','✈️','💻','🏠','👟','📚','💍','🎸']
                .map((e) => GestureDetector(
                  onTap: () => setSt(() => emoji = e),
                  child: AnimatedContainer(
                    duration: 200.ms,
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: emoji == e ? AppColors.primary.withValues(alpha: 0.15) : AppColors.cream300,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: emoji == e ? AppColors.primary : AppColors.border),
                    ),
                    child: Text(e, style: const TextStyle(fontSize: 18)),
                  ),
                )).toList()),
              const SizedBox(height: 16),
              FmTextField(
                label: 'Goal name', hint: 'e.g. New Laptop',
                controller: nameCtrl, prefixIcon: Icons.label_outline_rounded,
              ),
              const SizedBox(height: 16),
              FmTextField(
                label: 'Target amount (₹)', controller: amtCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                prefixIcon: Icons.currency_rupee_rounded,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
              ),
              const SizedBox(height: 24),
              FmButton(
                label: 'Create Goal', icon: Icons.flag_rounded,
                onPressed: () async {
                  if (nameCtrl.text.isEmpty || amtCtrl.text.isEmpty) return;
                  context.read<GoalBloc>().add(AddGoal(
                    userId: widget.user.id,
                    name: nameCtrl.text.trim(),
                    emoji: emoji,
                    targetAmount: double.tryParse(amtCtrl.text) ?? 0,
                  ));
                  if (ctx.mounted) Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showAddSavings(BuildContext context, GoalModel goal) {
    final amtCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cream200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 20, right: 20, top: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Center(child: Container(width: 40, height: 4,
            decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          Text('Add to ${goal.name}', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text('${CurrencyFormatter.format(goal.savedAmount)} / ${CurrencyFormatter.format(goal.targetAmount)}',
            style: const TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 20),
          FmTextField(
            label: 'Amount to add (₹)', controller: amtCtrl, autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            prefixIcon: Icons.add_circle_outline_rounded,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
          ),
          const SizedBox(height: 24),
          FmButton(
            label: 'Add Savings', icon: Icons.savings_rounded,
            onPressed: () async {
              final amt = double.tryParse(amtCtrl.text);
              if (amt == null || amt <= 0) return;
              context.read<GoalBloc>().add(AddGoalSavings(
                userId: widget.user.id,
                goalId: goal.id,
                amount: amt,
              ));
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ]),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final GoalModel goal;
  final VoidCallback onAddSavings;
  final VoidCallback onDelete;

  const _GoalCard({required this.goal, required this.onAddSavings, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final remaining = (goal.targetAmount - goal.savedAmount).clamp(0.0, double.infinity);
    final color = goal.isCompleted ? AppColors.accent : AppColors.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: goal.isCompleted ? AppColors.accent.withValues(alpha: 0.4) : AppColors.border),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          GoalRing(progress: goal.progress, size: 64, emoji: goal.emoji, color: color),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(goal.name, style: const TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              goal.isCompleted
                  ? '🎉 Goal reached!'
                  : '${CurrencyFormatter.formatCompact(remaining)} more to go',
              style: TextStyle(color: goal.isCompleted ? AppColors.accent : AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              '${CurrencyFormatter.formatCompact(goal.savedAmount)} / ${CurrencyFormatter.formatCompact(goal.targetAmount)}',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ])),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textMuted, size: 20),
            color: AppColors.surfaceElevated,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            itemBuilder: (_) => [
              PopupMenuItem(child: const Text('Delete', style: TextStyle(color: AppColors.expense)), onTap: onDelete),
            ],
          ),
        ]),
        if (!goal.isCompleted) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onAddSavings,
              icon: const Icon(Icons.add_rounded, size: 16),
              label: const Text('Add savings'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.borderBright),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ]),
    );
  }
}

class _EmptyGoals extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyGoals({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('🎯', style: TextStyle(fontSize: 56)).animate().scale(
            duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 16),
          Text('No goals yet', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          const Text('Set a savings goal and track your progress',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Create Goal'),
          ),
        ]),
      ),
    );
  }
}
