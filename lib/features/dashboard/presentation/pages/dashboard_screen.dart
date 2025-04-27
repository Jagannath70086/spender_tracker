import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/core/theme/app_colors.dart';
import 'package:spender_tracker/core/ui/widgets/manhattan_graph.dart';
import 'package:spender_tracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:spender_tracker/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:spender_tracker/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SpendingData> spendingData = [
      SpendingData("Last Month Card", 5800),
      SpendingData("Last Month Bank", 4200),
      SpendingData("This Month Card", 3700),
      SpendingData("This Month Bank", 2900),
    ];
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, dashboardState) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dashboardState.isBalanceVisible ? "₹1000.00" : "****",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  GestureDetector(
                    child: Icon(
                      dashboardState.isBalanceVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onTap: () {
                      context.read<DashboardBloc>().add(
                        ToggleBalanceVisibility(),
                      );
                    },
                  ),
                ],
              ),
              GestureDetector(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance,
                      size: 15,
                      color: Theme.of(
                        context,
                      ).iconTheme.color?.withValues(alpha: 0.7),
                    ),
                    SizedBox(width: 3),
                    Text(
                      dashboardState.isBalanceVisible
                          ? "Balance"
                          : "Outstanding",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(width: 5),
                    Transform.rotate(
                      angle: 1.5708,
                      child: Icon(
                        Icons.chevron_right_outlined,
                        size: 20,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  context.read<DashboardBloc>().add(ToggleBalanceVisibility());
                },
              ),
              Text(
                'last updated today at 9.38am',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 16),
              // ManhattanGraph(
              //   spendingData: spendingData,
              //   title: "Monthly Spending",
              // ),
            ],
          ),
        );
      },
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final String title;
  final String amount;
  final String lastUpdated;
  final IconData icon;
  final VoidCallback onTap;

  const _BalanceCard({
    required this.title,
    required this.amount,
    required this.lastUpdated,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? AppColors.primaryLight : AppColors.primaryDark,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onTap,
                child: Icon(icon, size: 20, color: theme.iconTheme.color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            amount,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            lastUpdated,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
