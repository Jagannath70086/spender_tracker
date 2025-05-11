import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spender_tracker/core/api/api_client.dart';
import 'package:spender_tracker/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/data/datasource/app_info_remote_datasource.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/data/repository/app_info_repository_impl.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/domain/repository/app_info_repository.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/bloc/app_info_bloc.dart';
import 'package:spender_tracker/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:spender_tracker/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:spender_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:spender_tracker/features/auth/data/repository/user_repository_impl.dart';
import 'package:spender_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:spender_tracker/features/auth/domain/repository/user_repository.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/data/repository/navigation_repository_impl.dart';
import 'package:spender_tracker/features/bottom_navbar/domain/repository/navigation_repository.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_bloc.dart';
import 'package:spender_tracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:spender_tracker/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:spender_tracker/features/theme/data/repository/theme_repository_impl.dart';
import 'package:spender_tracker/features/theme/domain/repository/theme_repository.dart';
import 'package:spender_tracker/features/theme/domain/usecase/get_theme_use_case.dart';
import 'package:spender_tracker/features/theme/domain/usecase/save_theme_use_case.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setup() async {
  registerApiClient();
  await registerSharedPreferences();
  registerDatasource();
  registerRepository();
  registerBloc();
  registerUseCases();
  setupNavigationDependencies();
}

void registerApiClient(){
  getIt.registerSingleton(ApiClient());
}

void registerDatasource(){
  var dio = getIt<ApiClient>().getDio();
  var dioWithTokenInterceptor = getIt<ApiClient>().getDio(tokenInterceptor: true);

  getIt.registerSingleton(AuthRemoteDatasource(dio: dio));
  getIt.registerSingleton(UserRemoteDatasource(dio: dioWithTokenInterceptor));

  getIt.registerSingleton(AppInfoRemoteDataSource(dio: dio));

  getIt.registerSingleton(ThemeLocalDataSource(sharedPreferences: getIt()));
}

void registerRepository(){
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(authRemoteDatasource: getIt()));
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl(userRemoteDatasource: getIt()));

  getIt.registerSingleton<AppInfoRepository>(AppInfoRepositoryImpl(remoteDataSource: getIt()));

  getIt.registerSingleton<ThemeRepository>(ThemeRepositoryImpl(themeLocalDataSource: getIt()));
}

void registerBloc(){
  getIt.registerFactory(() => UserBloc(authRepository: getIt(), userRepository: getIt()));
  getIt.registerFactory(() => AppInfoBloc(appInfoRepository: getIt()));
  getIt.registerFactory(() => ThemeBloc(getThemeUseCase: getIt(), saveThemeUseCase: getIt()));
  getIt.registerFactory(() => NavigationBloc(repository: getIt()));
  getIt.registerFactory(() => DashboardBloc());
  getIt.registerFactory(() => ProfileBloc());
}

Future<void> registerSharedPreferences() async {
  getIt.registerSingleton(await SharedPreferences.getInstance());
}

void registerUseCases() {
  getIt.registerSingleton(GetThemeUseCase(themeRepository: getIt()));
  getIt.registerSingleton(SaveThemeUseCase(themeRepository: getIt()));
}

void setupNavigationDependencies() {
  getIt.registerLazySingleton<NavigationRepository>(() => NavigationRepositoryImpl());
}
