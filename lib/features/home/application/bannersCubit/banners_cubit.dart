import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/home/application/bannersCubit/banners_states.dart';

class BannersCubit extends Cubit<BannersStates> {
  BannersCubit() : super(BannersInitialState());

  static BannersCubit get(context) => BlocProvider.of(context);

  //Variables
  //ads CarouselSlider
  int currentIndex = 0;
  List<String> imgList = [];
  //Methods
  //ads CarouselSlider
  void bannerChanges(int index) {
    currentIndex = index;
    emit(BannerChangeState());
  }

  getAdsImages() {
    emit(BannersLoadingState());
    imgList = [
      "assets/images/ads.png",
      "assets/images/boarding3.png",
      "assets/images/ads.png",
      "assets/images/boarding3.png",
      "assets/images/boarding2.png",
      "assets/images/boarding1.png",
    ];

    emit(BannersLoadedState(imgList));
  }
}
