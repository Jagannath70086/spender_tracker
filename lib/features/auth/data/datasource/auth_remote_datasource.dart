import 'package:dio/dio.dart';
import 'package:spender_tracker/features/auth/domain/model/user_model.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource({required this.dio});

  Future<UserModel> loginWithGoogle(String token) async {
    var request = await dio.post('users/login', data: {'token': token});
    return UserModel.fromJson(request.data);
  }
}