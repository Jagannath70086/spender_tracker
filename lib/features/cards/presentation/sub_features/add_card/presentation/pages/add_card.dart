import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/core/ui/widgets/default_text_field.dart';
import 'package:spender_tracker/features/cards/domain/model/card_model.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_bloc.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_event.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});

  static const String route = '/add-card';

  final _formKey = GlobalKey<FormState>();

  final bankNameController = TextEditingController();
  final variantController = TextEditingController();
  final lastFourController = TextEditingController();
  final totalLimitController = TextEditingController();
  final outstandingController = TextEditingController();
  final statementDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DefaultTextField(
                label: 'Bank Name',
                controller: bankNameController,
                icon: Icons.account_balance,
                onChanged: (val) => print('Bank name changed: $val'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              DefaultTextField(
                label: 'Card Variant',
                controller: variantController,
                icon: Icons.credit_card,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter card variant';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DefaultTextField(
                label: 'Last 4 Digits',
                controller: lastFourController,
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
                maxLength: 4,
                validator: (value) {
                  if (value == null || value.length != 4) return 'Enter 4 digits';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: DefaultTextField(
                      label: 'Total Limit',
                      controller: totalLimitController,
                      icon: Icons.account_balance_wallet,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DefaultTextField(
                      label: 'Outstanding',
                      controller: outstandingController,
                      icon: Icons.money_off,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              DefaultTextField(
                label: 'Statement Date',
                controller: statementDateController,
                icon: Icons.date_range,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final date = int.tryParse(value ?? '');
                  if (date == null || date < 1 || date > 31) return 'Enter valid date (1-31)';
                  return null;
                },
              ),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Card'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final card = CardModel(
                      bankName: bankNameController.text.trim(),
                      variant: variantController.text.trim(),
                      lastFourDigits: lastFourController.text.trim(),
                      totalLimit: double.tryParse(totalLimitController.text.trim()) ?? 0,
                      outstanding: double.tryParse(outstandingController.text.trim()) ?? 0,
                      statementDate: int.parse(statementDateController.text.trim()),
                    );

                    context.read<CardBloc>().add(AddCardEvent(card));
                    Navigator.pop(context); // Go back after adding
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
