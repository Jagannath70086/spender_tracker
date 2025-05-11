import 'package:equatable/equatable.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/domain/model/app_info_model.dart';

enum AppInfoStatus { initial, loading, success, error }

class AppInfoState extends Equatable {
  final AppInfoStatus status;
  final String? errorMessage;

  final AppInfoModel? appInfoModel;

  const AppInfoState._({required this.status, this.errorMessage, this.appInfoModel});

  factory AppInfoState.initial() => AppInfoState._(status: AppInfoStatus.initial);

  AppInfoState copyWith({
    AppInfoStatus? status,
    AppInfoModel? appInfoModel,
    String? errorMessage,
  }) {
    return AppInfoState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      appInfoModel: appInfoModel ?? this.appInfoModel,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, appInfoModel];
}

