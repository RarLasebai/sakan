
abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState implements SearchStates {}

class SearchResultLoadedState implements SearchStates {
  List houses;
  SearchResultLoadedState({required this.houses});
}
class SearchResultEmptyState implements SearchStates {
  final String message;
  SearchResultEmptyState(this.message);
}
class SearchErrorState implements SearchStates {
  final String message;
  SearchErrorState(this.message);
}
