import 'package:dio/dio.dart';
import 'package:spender_tracker/features/cards/domain/model/card_model.dart';

class CardRemoteDatasource {
  final Dio dio;

  CardRemoteDatasource({required this.dio});

  Future<List<CardModel>> getCards() async {
    final response = await dio.get('/cards');
    final data = response.data;

    if (data is List) {
      return data.map((e) => CardModel.fromJson(e)).toList();
    } else {
      throw Exception("Unexpected response format: ${data.runtimeType}");
    }
  }

  Future<CardModel> addCard(CardModel cardModel) async {
    final response = await dio.post('/cards', data: cardModel.toJson());
    return CardModel.fromJson(response.data);
  }

  Future<CardModel> updateCard(CardModel cardModel) async {
    final response = await dio.put('/cards', data: cardModel.toJson());
    return CardModel.fromJson(response.data);
  }

  Future<void> deleteCard(String cardId) async {
    await dio.delete('/cards/', data: {'cardId' : cardId});
  }

}
