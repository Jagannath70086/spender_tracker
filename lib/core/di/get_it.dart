import 'package:get_it/get_it.dart';
import 'package:spender_tracker/core/api/api_client.dart';
import 'package:spender_tracker/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:spender_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:spender_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  registerApiClient();
  registerDatasource();
  registerRepository();
  registerBloc();
}

void registerApiClient(){
  getIt.registerSingleton(ApiClient());
}

void registerDatasource(){
  var dio = getIt<ApiClient>().getDio();

  getIt.registerSingleton(AuthRemoteDatasource(dio: dio));
}

void registerRepository(){
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(authRemoteDatasource: getIt()));
}

void registerBloc(){
  getIt.registerFactory(() => UserBloc(authRepository: getIt()));
}