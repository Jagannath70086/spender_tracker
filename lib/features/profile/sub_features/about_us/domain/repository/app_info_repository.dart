import 'package:spender_tracker/core/failure/failure.dart';
import 'package:spender_tracker/core/model/either.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/domain/model/app_info_model.dart';

abstract class AppInfoRepository {
  Future<Either<Failure,AppInfoModel>> fetchAppInfo();
}
