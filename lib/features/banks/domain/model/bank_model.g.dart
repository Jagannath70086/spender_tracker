// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankModel _$BankModelFromJson(Map<String, dynamic> json) => BankModel(
  id: json['_id'] as String,
  bankName: json['bankName'] as String,
  lastFourDigits: json['lastFourDigits'] as String,
  currentBalance: (json['currentBalance'] as num).toDouble(),
  minBalance: (json['minBalance'] as num).toDouble(),
);

Map<String, dynamic> _$BankModelToJson(BankModel instance) => <String, dynamic>{
  if(instance.id != null)
  'id': instance.id,
  'bankName': instance.bankName,
  'lastFourDigits': instance.lastFourDigits,
  'currentBalance': instance.currentBalance,
  'minBalance': instance.minBalance,
};
