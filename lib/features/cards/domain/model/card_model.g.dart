// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
  id: json['_id'] as String,
  bankName: json['bankName'] as String,
  variant: json['variant'] as String,
  lastFourDigits: json['lastFourDigits'] as String,
  totalLimit: (json['totalLimit'] as num).toDouble(),
  outstanding: (json['outstanding'] as num).toDouble(),
  statementDate: (json['statementDate'] as num).toInt(),
);

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
  if(instance.id != null)
  'id': instance.id,
  'bankName': instance.bankName,
  'variant': instance.variant,
  'lastFourDigits': instance.lastFourDigits,
  'totalLimit': instance.totalLimit,
  'outstanding': instance.outstanding,
  'statementDate': instance.statementDate,
};
