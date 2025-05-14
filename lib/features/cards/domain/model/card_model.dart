import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  final String bankName;
  final String variant;
  final String lastFourDigits;
  final double totalLimit;
  final double outstanding;
  final int statementDate;

  const CardModel({
    this.id,
    required this.bankName,
    required this.variant,
    required this.lastFourDigits,
    required this.totalLimit,
    required this.outstanding,
    required this.statementDate,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    bankName,
    variant,
    lastFourDigits,
    totalLimit,
    outstanding,
    statementDate,
  ];
}

extension CardModelCopyWith on CardModel {
  CardModel copyWith({
    String? id,
    String? bankName,
    String? variant,
    String? lastFourDigits,
    double? totalLimit,
    double? outstanding,
    int? statementDate,
  }) {
    return CardModel(
      id: id ?? this.id,
      bankName: bankName ?? this.bankName,
      variant: variant ?? this.variant,
      lastFourDigits: lastFourDigits ?? this.lastFourDigits,
      totalLimit: totalLimit ?? this.totalLimit,
      outstanding: outstanding ?? this.outstanding,
      statementDate: statementDate ?? this.statementDate,
    );
  }
}
