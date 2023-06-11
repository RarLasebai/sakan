abstract class BannersStates {}

class BannersInitialState extends BannersStates {}

class BannersLoadingState implements BannersStates {}

class BannerChangeState extends BannersStates {}

class BannersLoadedState extends BannersStates {
  List imgList, ids;
  BannersLoadedState({required this.imgList, required this.ids});
}

// class HouseImagesLoadingState extends BannersStates {}
class HouseImagesLoadedState extends BannersStates {}

class BannerErrorState implements BannersStates {
  final String message;
  BannerErrorState(this.message);
}
