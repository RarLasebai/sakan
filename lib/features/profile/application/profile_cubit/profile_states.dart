import 'package:sakan/features/auth/data/model/user_model.dart';

import '../../../form/data/model/house_model.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileUpdatedSuccessfuly extends ProfileStates {
  final UserModel userModel;

  ProfileUpdatedSuccessfuly(this.userModel);
}

class ProfilePhotoPickedState extends ProfileStates {}

class ProfilePhotoURLState extends ProfileStates {
  final String photoUrl;
  ProfilePhotoURLState(this.photoUrl);
}

class NoDataChangedState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {}

class HousesIsEmptyState extends ProfileStates{}
class MyHousesLoadedState extends ProfileStates {
  List<HouseModel> houses;
  MyHousesLoadedState({required this.houses});
}

class ProfileErrorState implements ProfileStates {
  final String message;
  ProfileErrorState(this.message);
}
