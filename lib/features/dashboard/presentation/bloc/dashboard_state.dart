class DashboardState {
  final bool isBalanceVisible;
  final bool isBalanceLabel;
  final int amount;

  DashboardState({
    required this.isBalanceVisible,
    required this.isBalanceLabel,
    required this.amount
  });

  DashboardState copyWith({
    bool? isBalanceVisible,
    bool? isBalanceLabel,
    int? amount,
  }) {
    return DashboardState(
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
      isBalanceLabel: isBalanceLabel ?? this.isBalanceLabel,
      amount: amount ?? this.amount,
    );
  }
}
