import 'package:dio/dio.dart';
import 'package:spender_tracker/features/banks/domain/model/bank_model.dart';

class BankRemoteDatasource {
  final Dio dio;

  BankRemoteDatasource({required this.dio});

  Future<List<BankModel>> getBanks() async {
    final response = await dio.get('/banks');
    final data = response.data;

    if (data is List) {
      return data.map((e) => BankModel.fromJson(e)).toList();
    } else {
      throw Exception("Unexpected response format: ${data.runtimeType}");
    }
  }

  Future<BankModel> addBank(BankModel bankModel) async {
    final response = await dio.post('/banks', data: bankModel.toJson());
    return BankModel.fromJson(response.data);
  }

  Future<BankModel> updateBank(BankModel bankModel) async {
    final response = await dio.put('/banks', data: bankModel.toJson());
    return BankModel.fromJson(response.data);
  }

  Future<void> deleteBank(String bankId) async {
    await dio.delete('/banks/', data: {'bankId' : bankId});
  }

}
