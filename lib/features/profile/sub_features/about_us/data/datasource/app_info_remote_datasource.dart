import 'package:dio/dio.dart';

class AppInfoRemoteDataSource {
  final Dio dio;

  AppInfoRemoteDataSource({required this.dio});

  Future<Map<String, dynamic>> getAppInfo() async {
    var response = await dio.get('/app_info');
    return response.data;
  }
}
