class ProfileState {
  final bool isSwipeActionsEnabled;

  ProfileState(this.isSwipeActionsEnabled);

  factory ProfileState.initial() => ProfileState(true);

  ProfileState copyWith({bool? isSwipeActionsEnabled}) {
    return ProfileState(isSwipeActionsEnabled ?? this.isSwipeActionsEnabled);
  }
}