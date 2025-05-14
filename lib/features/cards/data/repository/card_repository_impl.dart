import 'package:dio/dio.dart';
import 'package:spender_tracker/core/failure/failure.dart';
import 'package:spender_tracker/core/model/either.dart';
import 'package:spender_tracker/features/cards/data/datasource/card_remote_datasource.dart';
import 'package:spender_tracker/features/cards/domain/model/card_model.dart';
import 'package:spender_tracker/features/cards/domain/repository/card_repository.dart';

class CardRepositoryImpl implements CardRepository{
  final CardRemoteDatasource cardRemoteDatasource;

  CardRepositoryImpl({required this.cardRemoteDatasource});

  @override
  Future<Either<Failure, List<CardModel>>> getCards() async{
    try {
      return Either.right(await cardRemoteDatasource.getCards());
    }
    on DioException catch(e){
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch(e){
      return Either.left(AuthFailure(message: 'Authorization failure'));
    }

  }

  @override
  Future<Either<Failure, CardModel>> addCard(CardModel cardModel) async {
    try {
      return Either.right(await cardRemoteDatasource.addCard(cardModel));
    }
    on DioException catch(e){
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch(e) {
      return Either.left(AuthFailure(message: 'Authorization failure'));
    }
  }

  @override
  Future<Either<Failure, CardModel>> updateCard(CardModel cardModel) async {
    try {
      return Either.right(await cardRemoteDatasource.updateCard(cardModel));
    }
    on DioException catch (e) {
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch (e) {
      return Either.left(AuthFailure(message: 'Authorization failure'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCard(String cardId) async {
    try {
      await cardRemoteDatasource.deleteCard(cardId);
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