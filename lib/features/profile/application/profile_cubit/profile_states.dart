import 'package:sakan/features/auth/data/model/user_model.dart';

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

class ProfileSuccessState extends ProfileStates {}

class ProfileErrorState implements ProfileStates {
  final String message;
  ProfileErrorState(this.message);
}
