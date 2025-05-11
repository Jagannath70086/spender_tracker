import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_info_model.g.dart';

@JsonSerializable()
class AppInfoModel extends Equatable {
  @JsonKey(name: 'current_version')
  final String? name;
  final String? description;
  final String? currentVersion;
  final String? latestVersion;
  final String? buildNumber;
  final String? termsOfService;
  final String? privacyPolicy;
  final String? contactEmail;
  final String? releaseNotes;
  final bool? forceUpdate;
  final String? platform;

  const AppInfoModel({
    required this.name,
    required this.description,
    required this.currentVersion,
    required this.latestVersion,
    required this.buildNumber,
    required this.termsOfService,
    required this.privacyPolicy,
    required this.contactEmail,
    required this.releaseNotes,
    required this.forceUpdate,
    required this.platform,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AppInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppInfoModelToJson(this);

  @override
  List<Object?> get props => [
    name,
    description,
    currentVersion,
    latestVersion,
    buildNumber,
    termsOfService,
    privacyPolicy,
    contactEmail,
    releaseNotes,
    forceUpdate,
    platform,
  ];
}
