import 'package:sakan/features/auth/data/model/user_model.dart';

abstract class ForgetPassStates {}

class ForgetPassInitialState extends ForgetPassStates {}

class ForgetPassLoadingState extends ForgetPassStates {}

class UserFoundState extends ForgetPassStates {
  UserModel userModel;
  UserFoundState(this.userModel);
}

//code sent to user after check the phone is exist in the firestore = ForgetPassCodeSentState
class ForgetPassCodeSentState extends ForgetPassStates {
  final String verId;
  final UserModel user;
  ForgetPassCodeSentState({required this.verId, required this.user});
}

//UserNotFound on the firestore = ForgetPassUserNotFoundState
class ForgetPassUserNotFoundState extends ForgetPassStates {}

//user phone is exist and he entered a true otp = ForgetPassVerifiedState
class ForgetPassVerifiedState extends ForgetPassStates {}

class PasswordChangedSuccessState extends ForgetPassStates {}

class ForgetPassFailState extends ForgetPassStates {}

class ForgetPassErrorState implements ForgetPassStates {
  final String message;
  ForgetPassErrorState(this.message);
}
