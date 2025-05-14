import 'package:equatable/equatable.dart';
import 'package:spender_tracker/features/banks/domain/model/bank_model.dart';

enum BankStatus { initial, loading, success, error }

class BankState extends Equatable {
  final BankStatus status;
  final String? errorMessage;

  final List<BankModel>? bankModels;

  const BankState._({required this.status, this.errorMessage, this.bankModels});

  factory BankState.initial() => BankState._(status: BankStatus.initial);

  BankState copyWith({
    BankStatus? status,
    List<BankModel>? bankModels,
    String? errorMessage,
  }) {
    return BankState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      bankModels: bankModels ?? this.bankModels,
    );
  }
  @override
  List<Object?> get props => [status, errorMessage, bankModels];
}
