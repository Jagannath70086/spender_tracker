import 'package:spender_tracker/core/failure/failure.dart';
import 'package:spender_tracker/core/model/either.dart';
import 'package:spender_tracker/features/cards/domain/model/card_model.dart';

abstract class CardRepository {
  Future<Either<Failure, List<CardModel>>> getCards();
  Future<Either<Failure, CardModel>> addCard(CardModel cardModel);
  Future<Either<Failure, CardModel>> updateCard(CardModel cardModel);
  Future<Either<Failure, void>> deleteCard(String cardId);
}