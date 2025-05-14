// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfoModel _$AppInfoModelFromJson(Map<String, dynamic> json) => AppInfoModel(
  name: json['current_version'] as String?,
  description: json['description'] as String?,
  currentVersion: json['currentVersion'] as String?,
  latestVersion: json['latestVersion'] as String?,
  buildNumber: json['buildNumber'] as String?,
  termsOfService: json['termsOfService'] as String?,
  privacyPolicy: json['privacyPolicy'] as String?,
  contactEmail: json['contactEmail'] as String?,
  releaseNotes: json['releaseNotes'] as String?,
  forceUpdate: json['forceUpdate'] as bool?,
  platform: json['platform'] as String?,
);

Map<String, dynamic> _$AppInfoModelToJson(AppInfoModel instance) =>
    <String, dynamic>{
      'current_version': instance.name,
      'description': instance.description,
      'currentVersion': instance.currentVersion,
      'latestVersion': instance.latestVersion,
      'buildNumber': instance.buildNumber,
      'termsOfService': instance.termsOfService,
      'privacyPolicy': instance.privacyPolicy,
      'contactEmail': instance.contactEmail,
      'releaseNotes': instance.releaseNotes,
      'forceUpdate': instance.forceUpdate,
      'platform': instance.platform,
    };
