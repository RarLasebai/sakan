import '../../../form/data/model/house_model.dart';

abstract class FavoriteStates {}

class FavoriteInitialState extends FavoriteStates {}

class FavoriteLoadingState implements FavoriteStates {}
class FavoriteHousesEmptyState implements FavoriteStates {}

class FavoriteHousesLoadedState extends FavoriteStates {
  List<HouseModel> houses;
  FavoriteHousesLoadedState({required this.houses});
}

class FavoriteErrorState implements FavoriteStates {
  final String message;
  FavoriteErrorState(this.message);
}
