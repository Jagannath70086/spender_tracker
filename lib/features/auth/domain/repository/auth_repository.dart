import 'package:spender_tracker/core/failure/failure.dart';
import 'package:spender_tracker/core/model/either.dart';
import 'package:spender_tracker/features/auth/domain/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure,UserModel>> loginWithGoogle();
}