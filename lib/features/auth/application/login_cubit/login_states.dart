import 'package:sakan/features/auth/data/model/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSavedSuccessState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final UserModel user;
  LoginSuccessState(this.user);
}

class UserNotFoundState extends LoginStates {}

class UserNotSavedLocally implements LoginStates {
  final String message;
  UserNotSavedLocally(this.message);
}

class LoginErrorState implements LoginStates {
  final String message;
  LoginErrorState(this.message);
}
