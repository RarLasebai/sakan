abstract class FormStates {}

class FormInitialState extends FormStates {}

class FormRadioButtonChangedState extends FormStates {
  final String message;
  FormRadioButtonChangedState(this.message);
}


class HouseTypeErrorState extends FormStates {
  final String message;
  HouseTypeErrorState(this.message);
}

class FormLoadingState extends FormStates {}

class PickingImageLoadingState extends FormStates {}

class PickingImageSuccessState extends FormStates {}

class PickingImageErrorState extends FormStates {
  final String message;

  PickingImageErrorState(this.message);
}

class FormSentSuccessfuly extends FormStates {
  FormSentSuccessfuly();
}

class FormErrorState implements FormStates {
  final String message;
  FormErrorState(this.message);
}
