abstract class DashboardEvent {}

class ToggleBalanceVisibility extends DashboardEvent {}

class ToggleAmountType extends DashboardEvent {

  final bool isBalanceLabel;

  ToggleAmountType(this.isBalanceLabel);
}
