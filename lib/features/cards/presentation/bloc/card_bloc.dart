import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/cards/domain/repository/card_repository.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_event.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({required this.cardRepository}) : super(CardState.initial()) {
    on<LoadCardEvent>(onLoadCardEvent);
    on<AddCardEvent>(onAddCardEvent);
    on<DeleteCardEvent>(onDeleteCardEvent);
    on<UpdateCardEvent>(onUpdateCardEvent);
  }

  Future onLoadCardEvent(LoadCardEvent event, Emitter emit) async {
    emit(state.copyWith(status: CardStatus.loading));
    var data = await cardRepository.getCards();
    if (data.isRight()) {
      emit(state.copyWith(status: CardStatus.success, cardModels: data.right));
    } else {
      emit(
        state.copyWith(
          status: CardStatus.error,
          errorMessage: data.left.message,
        ),
      );
    }
  }

  Future onAddCardEvent(AddCardEvent event, Emitter emit) async {
    emit(state.copyWith(status: CardStatus.loading));
    var data = await cardRepository.addCard(event.cardModel);
    if (data.isRight()) {
      emit(
        state.copyWith(
          status: CardStatus.success,
          cardModels: [data.right, ...?state.cardModels],
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CardStatus.error,
          errorMessage: data.left.message,
        ),
      );
    }
  }

  Future onDeleteCardEvent(DeleteCardEvent event, Emitter emit) async {
    emit(state.copyWith(status: CardStatus.loading));
    var data = await cardRepository.deleteCard(event.cardId);
    if (data.isRight()) {
      emit(
        state.copyWith(
          status: CardStatus.success,
          cardModels:
              state.cardModels
                  ?.where((element) => element.id != event.cardId)
                  .toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CardStatus.error,
          errorMessage: data.left.message,
        ),
      );
    }
  }

  Future onUpdateCardEvent(UpdateCardEvent event, Emitter emit) async {
    emit(state.copyWith(status: CardStatus.loading));

    final result = await cardRepository.updateCard(event.cardModel);

    if (result.isRight()) {
      final updatedCard = result.right;

      final updatedList =
          state.cardModels?.map((card) {
            return card.id == updatedCard.id ? updatedCard : card;
          }).toList();

      emit(state.copyWith(status: CardStatus.success, cardModels: updatedList));
    } else {
      emit(
        state.copyWith(
          status: CardStatus.error,
          errorMessage: result.left.message,
        ),
      );
    }
  }
}
