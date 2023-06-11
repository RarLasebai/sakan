import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/form/data/model/house_model.dart';
import 'package:sakan/features/home/application/bannersCubit/banners_states.dart';
import 'package:sakan/features/home/data/models/banners_model.dart';

class BannersCubit extends Cubit<BannersStates> {
  BannersCubit() : super(BannersInitialState());

  static BannersCubit get(context) => BlocProvider.of(context);

  //Variables
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //ads CarouselSlider
  int currentIndex = 0;
  List imgList = [];
  List ids = [];
  //Methods
  //ads CarouselSlider
  void bannerChanges(int index) {
    currentIndex = index;
    emit(BannerChangeState());
  }

  getAdsImages() async {
    emit(BannersLoadingState());

    DocumentSnapshot<Map<String, dynamic>> bannersList =
        await _firestore.collection("banners").doc("images").get();
    BannersModel bannersModel = BannersModel.fromMap(bannersList.data()!);
    imgList = bannersModel.bannersImages;
    ids = bannersModel.ids;

    //  = [
    //   "assets/images/ads.png",
    //   "assets/images/boarding3.png",
    //   "assets/images/ads.png",
    //   "assets/images/boarding3.png",
    //   "assets/images/boarding2.png",
    //   "assets/images/boarding1.png",
    // ];

    emit(BannersLoadedState(imgList:  imgList, ids: ids));
  }

   Future<HouseModel> getHouseFromImage(String houseId) async {
    DocumentSnapshot<Map<String, dynamic>> house =
        await _firestore.collection("houses").doc(houseId).get();
    HouseModel h = HouseModel.fromMap(house.data()!);
    return h;
  }

}
