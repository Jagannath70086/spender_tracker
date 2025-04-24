import 'package:equatable/equatable.dart';
import 'package:spender_tracker/features/auth/domain/model/user_model.dart';

enum UserStatus { initial, loading, success, error }

class UserState extends Equatable {
  final UserStatus status;
  final String? errorMessage;

  final UserModel? userModel;

  const UserState._({required this.status, this.errorMessage, this.userModel});

  factory UserState.initial() => UserState._(status: UserStatus.initial);

  UserState copyWith({
    UserStatus? status,
    UserModel? userModel,
    String? errorMessage,
  }) {
    return UserState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, userModel];
}
