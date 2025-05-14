import 'package:spender_tracker/features/cards/domain/model/card_model.dart';

abstract class CardEvent {

}

class LoadCardEvent extends CardEvent {

}

class AddCardEvent extends CardEvent {
  final CardModel cardModel;
  AddCardEvent(this.cardModel);
}

class DeleteCardEvent extends CardEvent {
  final String cardId;
  DeleteCardEvent(this.cardId);
}

class UpdateCardEvent extends CardEvent {
  final CardModel cardModel;
  UpdateCardEvent(this.cardModel);
}

