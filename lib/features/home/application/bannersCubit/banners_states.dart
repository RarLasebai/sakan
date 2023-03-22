abstract class BannersStates{}
class BannersInitialState extends BannersStates{}

class BannersLoadedState implements BannersStates{}


class BannerChangeState extends BannersStates {}

class BannerErrorState implements BannersStates {
  final String message;
  BannerErrorState(this.message);
}
