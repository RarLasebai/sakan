
import 'package:sakan/features/auth/data/model/user_model.dart';

abstract class AuthStates{}

class AuthInitialState extends   AuthStates{}
 
class AuthLoadingState extends   AuthStates{}
 
class AuthSuccessState extends   AuthStates{
  final UserModel userModel;
  AuthSuccessState(this.userModel);
}

class AuthGetUser extends   AuthStates{
  final UserModel userModel;
  AuthGetUser(this.userModel);
}

class AuthFailState extends   AuthStates{}

class AuthErrorState implements  AuthStates {
  final String message;
  AuthErrorState(this.message);
}