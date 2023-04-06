import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utils/functions/utils_functios.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:sakan/features/profile/application/profile_cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
// Variables
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();

  GlobalKey<FormState> editProfileDataKey = GlobalKey<FormState>();

  String? image;

//Functions

  Future updateProfileData(UserModel userModel) async {
    emit(ProfileLoadingState());
    if (nameController.text.isEmpty &&
        nationalityController.text.isEmpty &&
        addressController.text.isEmpty &&
        image == null) {
      emit(NoDataChangedState());
    } else {
      try {
        await _firestore.collection("users").doc(userModel.userId).update({
          "userName": nameController.text.isEmpty
              ? userModel.userName
              : nameController.text,
          "userNationality": nationalityController.text.isEmpty
              ? userModel.userNationality
              : nationalityController.text,
          "userAddress": addressController.text.isEmpty
              ? userModel.userAddress
              : addressController.text,
          "userPhoto": image ?? userModel.userPhoto
        }).then((value) {
          nameController.clear();
          nationalityController.clear();
          addressController.clear();
        });

        QuerySnapshot query = await _firestore
            .collection("users")
            .where("userId", isEqualTo: userModel.userId)
            .get();

        query.docs.forEach((element) async {
          final data = element.data() as Map<String, dynamic>;
          UserModel user = UserModel.fromMap(data);
          await storeDataLocally(user);
          user = await getDataFromSharedPref();
          emit(ProfileUpdatedSuccessfuly(user));
        });
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    }
  }

  changePhoto(BuildContext context, UserModel user) async {
    final imageFile = await pickImage(context);

    emit(ProfilePhotoPickedState());
    final String photoUrl =
        await storeFileToStorage("profilePic/${user.userId}", imageFile!);
    image = photoUrl;
    emit(ProfilePhotoURLState(photoUrl));

    //then i guess we need to update the model
  }
}
