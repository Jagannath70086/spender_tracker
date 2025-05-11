import 'package:package_info_plus/package_info_plus.dart';
import 'package:spender_tracker/core/failure/failure.dart';
import 'package:spender_tracker/core/model/either.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/data/datasource/app_info_remote_datasource.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/domain/model/app_info_model.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/domain/repository/app_info_repository.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  final AppInfoRemoteDataSource remoteDataSource;

  AppInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AppInfoModel>> fetchAppInfo() async {
    try {
      final remoteInfo = await remoteDataSource.getAppInfo();
      final packageInfo = await PackageInfo.fromPlatform();

      final appInfo = AppInfoModel(
        name: remoteInfo["appName"],
        description: remoteInfo["description"],
        currentVersion: packageInfo.version,
        latestVersion: remoteInfo["latestVersion"],
        buildNumber: packageInfo.buildNumber,
        termsOfService: remoteInfo["termsOfService"],
        privacyPolicy: remoteInfo["privacyPolicy"],
        contactEmail: remoteInfo["contactEmail"],
        releaseNotes: remoteInfo["releaseNotes"],
        forceUpdate: remoteInfo["forceUpdate"],
        platform: remoteInfo["platform"],
      );

      return Either.right(appInfo);
    } catch (e) {
      return Either.left(DataFailure(message: e.toString()));
    }
  }
}
