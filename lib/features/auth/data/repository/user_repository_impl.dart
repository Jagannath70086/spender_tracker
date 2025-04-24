import 'package:dio/dio.dart';
import 'package:spender_tracker/core/failure/failure.dart';
import 'package:spender_tracker/core/model/either.dart';
import 'package:spender_tracker/features/auth/domain/model/user_model.dart';
import 'package:spender_tracker/features/auth/domain/repository/user_repository.dart';

import '../datasource/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl({required this.userRemoteDatasource});

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      return Either.right(await userRemoteDatasource.getUser());
    }
    on DioException catch(e){
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch(e){
      return Either.left(AuthFailure(message: 'Authorization failure'));
    }
  }

}