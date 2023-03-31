abstract class SignupStates{}

class SignupInitialState extends   SignupStates{}
 
class SignupLoadingState extends   SignupStates{}
 
class SignupSuccessState extends   SignupStates{}
 
 class RadioButtonChangeState implements  SignupStates {
  final String message;
  RadioButtonChangeState(this.message);
}
 class OtpVerifiedSuccessState extends   SignupStates{}
 class CodeSentSuccessState extends   SignupStates{
  final String verificationId;
  CodeSentSuccessState(this.verificationId);
 }

class SignupErrorState implements  SignupStates {
  final String message;
  SignupErrorState(this.message);
}