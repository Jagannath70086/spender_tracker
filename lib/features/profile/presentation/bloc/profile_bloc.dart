import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/profile/presentation/bloc/profile_event.dart';
import 'package:spender_tracker/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState(true)) {
    on<ToggleSwipeAction>((event, emit) {
      emit(state.copyWith(isSwipeActionsEnabled: !state.isSwipeActionsEnabled));
    });
  }
}