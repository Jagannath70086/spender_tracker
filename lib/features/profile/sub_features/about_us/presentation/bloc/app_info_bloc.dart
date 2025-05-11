import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/domain/repository/app_info_repository.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/bloc/app_info_event.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/bloc/app_info_state.dart';

class AppInfoBloc extends Bloc<AppInfoEvent,AppInfoState>{
  final AppInfoRepository appInfoRepository;

  AppInfoBloc({required this.appInfoRepository}) : super(AppInfoState.initial()) {
    on<FetchAppInfo>(onFetchAppInfo);
  }

  Future onFetchAppInfo(FetchAppInfo event, Emitter emit) async {
    emit(state.copyWith(status: AppInfoStatus.loading));
    var data = await appInfoRepository.fetchAppInfo();
    if(data.isRight()){
      emit(state.copyWith(status: AppInfoStatus.success, appInfoModel: data.right));
    }
    else {
      emit(state.copyWith(status: AppInfoStatus.error, errorMessage: data.left.message));
    }
  }
}