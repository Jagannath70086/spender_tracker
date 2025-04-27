import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:spender_tracker/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState(isBalanceVisible: false, isBalanceLabel: true, amount: 1000)) {
    on<ToggleBalanceVisibility>(_onToggleBalanceVisibility);
    on<ToggleAmountType>(_onToggleAmountType);
  }

  void _onToggleBalanceVisibility(
      ToggleBalanceVisibility event,
      Emitter<DashboardState> emit,
      ) {
    emit(state.copyWith(isBalanceVisible: !state.isBalanceVisible));
  }

  void _onToggleAmountType(
      ToggleAmountType event,
      Emitter<DashboardState> emit,
      ) {
    emit(state.copyWith(isBalanceLabel: event.isBalanceLabel, amount: -100));
  }
}