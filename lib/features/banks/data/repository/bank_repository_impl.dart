import 'package:dio/dio.dart';
import 'package:spender_tracker/core/failure/failure.dart';
import 'package:spender_tracker/core/model/either.dart';
import 'package:spender_tracker/features/banks/data/datasource/bank_remote_datasource.dart';
import 'package:spender_tracker/features/banks/domain/model/bank_model.dart';
import 'package:spender_tracker/features/banks/domain/repository/bank_repository.dart';

class BankRepositoryImpl implements BankRepository{
  final BankRemoteDatasource bankRemoteDatasource;

  BankRepositoryImpl({required this.bankRemoteDatasource});

  @override
  Future<Either<Failure, List<BankModel>>> getBanks() async{
    try {
      return Either.right(await bankRemoteDatasource.getBanks());
    }
    on DioException catch(e){
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch(e){
      return Either.left(AuthFailure(message: 'Authorization failure'));
    }

  }

  @override
  Future<Either<Failure, BankModel>> addBank(BankModel bankModel) async {
    try {
      return Either.right(await bankRemoteDatasource.addBank(bankModel));
    }
    on DioException catch(e){
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch(e) {
      return Either.left(AuthFailure(message: 'Authorization failure'));
    }
  }

  @override
  Future<Either<Failure, BankModel>> updateBank(BankModel bankModel) async {
    try {
      return Either.right(await bankRemoteDatasource.updateBank(bankModel));
    }
    on DioException catch (e) {
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch (e) {
      return Either.left(AuthFailure(message: 'Authorization failure'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBank(String bankId) async {
    try {
      await bankRemoteDatasource.deleteBank(bankId);
      return Either.right(0);
    }
    on DioException catch (e) {
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch (e) {
      return Either.left(AuthFailure(message: 'Authorization failure'));
    }
  }
}