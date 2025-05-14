import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/banks/domain/repository/bank_repository.dart';
import 'package:spender_tracker/features/banks/presentation/bloc/bank_event.dart';
import 'package:spender_tracker/features/banks/presentation/bloc/bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  final BankRepository bankRepository;

  BankBloc({required this.bankRepository}) : super(BankState.initial()) {
    on<LoadBankEvent>(onLoadBankEvent);
    on<AddBankEvent>(onAddBankEvent);
    on<DeleteBankEvent>(onDeleteBankEvent);
    on<UpdateBankEvent>(onUpdateBankEvent);
  }

  Future onLoadBankEvent(LoadBankEvent event, Emitter emit) async {
    emit(state.copyWith(status: BankStatus.loading));
    var data = await bankRepository.getBanks();
    if (data.isRight()) {
      emit(state.copyWith(status: BankStatus.success, bankModels: data.right));
    } else {
      emit(
        state.copyWith(
          status: BankStatus.error,
          errorMessage: data.left.message,
        ),
      );
    }
  }

  Future onAddBankEvent(AddBankEvent event, Emitter emit) async {
    emit(state.copyWith(status: BankStatus.loading));
    var data = await bankRepository.addBank(event.bankModel);
    if (data.isRight()) {
      emit(
        state.copyWith(
          status: BankStatus.success,
          bankModels: [data.right, ...?state.bankModels],
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: BankStatus.error,
          errorMessage: data.left.message,
        ),
      );
    }
  }

  Future onDeleteBankEvent(DeleteBankEvent event, Emitter emit) async {
    emit(state.copyWith(status: BankStatus.loading));
    var data = await bankRepository.deleteBank(event.bankId);
    if (data.isRight()) {
      emit(
        state.copyWith(
          status: BankStatus.success,
          bankModels:
              state.bankModels
                  ?.where((element) => element.id != event.bankId)
                  .toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: BankStatus.error,
          errorMessage: data.left.message,
        ),
      );
    }
  }

  Future onUpdateBankEvent(UpdateBankEvent event, Emitter emit) async {
    emit(state.copyWith(status: BankStatus.loading));

    final result = await bankRepository.updateBank(event.bankModel);

    if (result.isRight()) {
      final updatedBank = result.right;

      final updatedList =
          state.bankModels?.map((bank) {
            return bank.id == updatedBank.id ? updatedBank : bank;
          }).toList();

      emit(state.copyWith(status: BankStatus.success, bankModels: updatedList));
    } else {
      emit(
        state.copyWith(
          status: BankStatus.error,
          errorMessage: result.left.message,
        ),
      );
    }
  }
}
