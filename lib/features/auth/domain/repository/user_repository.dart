import '../../../../core/failure/failure.dart';
import '../../../../core/model/either.dart';
import '../model/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getUser();
}