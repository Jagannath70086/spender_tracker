import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_model.g.dart';

@JsonSerializable()
class BankModel extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  final String bankName;
  final String lastFourDigits;
  final double currentBalance;
  final double minBalance;

  const BankModel({
    this.id,
    required this.bankName,
    required this.lastFourDigits,
    required this.currentBalance,
    required this.minBalance,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) =>
      _$BankModelFromJson(json);

  Map<String, dynamic> toJson() => _$BankModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    bankName,
    lastFourDigits,
    currentBalance,
    minBalance,
  ];
}

extension BankModelCopyWith on BankModel {
  BankModel copyWith({
    String? id,
    String? bankName,
    String? lastFourDigits,
    double? currentBalance,
    double? minBalance,
  }) {
    return BankModel(
      id: id ?? this.id,
      bankName: bankName ?? this.bankName,
      lastFourDigits: lastFourDigits ?? this.lastFourDigits,
      currentBalance: currentBalance ?? this.currentBalance,
      minBalance: minBalance ?? this.minBalance,
    );
  }
}
