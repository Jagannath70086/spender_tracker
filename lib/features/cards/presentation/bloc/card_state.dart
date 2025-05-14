import 'package:equatable/equatable.dart';
import 'package:spender_tracker/features/cards/domain/model/card_model.dart';

enum CardStatus { initial, loading, success, error }

class CardState extends Equatable {
  final CardStatus status;
  final String? errorMessage;

  final List<CardModel>? cardModels;

  const CardState._({required this.status, this.errorMessage, this.cardModels});

  factory CardState.initial() => CardState._(status: CardStatus.initial);

  CardState copyWith({
    CardStatus? status,
    List<CardModel>? cardModels,
    String? errorMessage,
  }) {
    return CardState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      cardModels: cardModels ?? this.cardModels,
    );
  }
  @override
  List<Object?> get props => [status, errorMessage, cardModels];
}
