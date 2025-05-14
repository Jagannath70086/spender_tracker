import 'package:spender_tracker/features/banks/domain/model/bank_model.dart';

abstract class BankEvent {

}

class LoadBankEvent extends BankEvent {

}

class AddBankEvent extends BankEvent {
  final BankModel bankModel;
  AddBankEvent(this.bankModel);
}

class DeleteBankEvent extends BankEvent {
  final String bankId;
  DeleteBankEvent(this.bankId);
}

class UpdateBankEvent extends BankEvent {
  final BankModel bankModel;
  UpdateBankEvent(this.bankModel);
}

