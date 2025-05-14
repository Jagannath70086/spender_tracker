import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spender_tracker/core/theme/app_colors.dart';
import 'package:spender_tracker/features/cards/domain/model/card_model.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_bloc.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_event.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_state.dart';
import 'package:spender_tracker/features/cards/presentation/sub_features/add_card/presentation/pages/add_card.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = context.select(
      (CardBloc bloc) => bloc.state.cardModels ?? [],
    );
    if (cards.isEmpty) {
      return _buildEmptyState(context);
    }
    return _buildCardsList(context, cards);
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
                child: const Icon(
                  Icons.credit_card,
                  size: 60,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'No Cards Yet',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'You haven\'t added any payment cards to your account yet. Add your first card to start managing your expenses.',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton.icon(
                onPressed: () {
                  context.push(AddCard.route);
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('ADD NEW CARD'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
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

  Widget _buildCardsList(BuildContext context, List<CardModel> cards) {
    return Center(child: Column(children: cards.map((card) => Text(card.bankName)).toList()));
  }
}
