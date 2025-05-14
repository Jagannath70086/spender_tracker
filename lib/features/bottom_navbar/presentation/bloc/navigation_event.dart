abstract class NavigationEvent{

}

class GetNavigationItemsEvent extends NavigationEvent {

}

class NavigationItemSelectedEvent extends NavigationEvent {
  final String itemId;

  NavigationItemSelectedEvent(this.itemId);
}