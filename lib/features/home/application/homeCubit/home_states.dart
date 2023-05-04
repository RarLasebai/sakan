import '../../../form/data/model/house_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState implements HomeStates {}

class HouseIndexChangeState extends HomeStates {}

class LatestHousesLoadedState extends HomeStates {
  List<HouseModel> houses;
  LatestHousesLoadedState({required this.houses});
}

class HouseWithTypeLoadingState implements HomeStates {}

class HouseWithTypeLoadedState extends HomeStates {
  List<HouseModel> houses;
  HouseWithTypeLoadedState({required this.houses});
}

class NoHousesInThisTypeState implements HomeStates {
  final String message;
  NoHousesInThisTypeState(this.message);
}

class AddHouseToFavLoadingState extends HomeStates {}

class FavColorChangeState extends HomeStates {}

class AddHouseToFavSuccessState extends HomeStates {}

class RemoveHouseFromFavSuccessState extends HomeStates {}

class HomeErrorState implements HomeStates {
  final String message;
  HomeErrorState(this.message);
}
