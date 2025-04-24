import 'package:dio/dio.dart';

import '../../domain/model/user_model.dart';

class UserRemoteDatasource {
  final Dio dio;

  UserRemoteDatasource({required this.dio});

  Future<UserModel> getUser() async {
    final request = await dio.get('/users/profile');

    return UserModel.fromJson(request.data);
  }

}