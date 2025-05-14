import 'package:spender_tracker/core/failure/failure.dart';
import 'package:spender_tracker/core/model/either.dart';
import 'package:spender_tracker/features/banks/domain/model/bank_model.dart';

abstract class BankRepository {
  Future<Either<Failure, List<BankModel>>> getBanks();
  Future<Either<Failure, BankModel>> addBank(BankModel bankModel);
  Future<Either<Failure, BankModel>> updateBank(BankModel bankModel);
  Future<Either<Failure, void>> deleteBank(String bankId);
}