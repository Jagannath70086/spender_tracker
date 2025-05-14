import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spender_tracker/core/theme/app_colors.dart';
import 'package:spender_tracker/features/banks/domain/model/bank_model.dart';
import 'package:spender_tracker/features/banks/presentation/bloc/bank_bloc.dart';
import 'package:spender_tracker/features/banks/presentation/bloc/bank_event.dart';
import 'package:spender_tracker/features/banks/presentation/bloc/bank_state.dart';
import 'package:spender_tracker/features/banks/presentation/sub_features/add_bank/presentation/pages/add_bank.dart';

class BanksScreen extends StatelessWidget {
  const BanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banks = context.select(
          (BankBloc bloc) => bloc.state.bankModels ?? [],
    );
    if (banks.isEmpty) {
      return _buildEmptyState(context);
    }
    return _buildBanksList(context, banks);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.account_balance,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'No Banks Yet',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'You haven\'t added any banks to your account yet. Add your first bank to start managing your expenses.',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton.icon(
                onPressed: () {
                  context.push(AddBank.route);
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('ADD NEW BANK'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanksList(BuildContext context, List<BankModel> banks) {
    return Text('banks');
  }
}
