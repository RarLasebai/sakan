import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

Future<UserModel> getDataFromSharedPref() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sharedPreferences.reload();
  String data = sharedPreferences.getString("user_model") ?? '';
  final userModel = UserModel.fromMap(jsonDecode(data));
  return userModel;
}

Future storeDataLocally(UserModel userModel) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  await sharedPreferences.setString(
      "user_model", jsonEncode(userModel.toMap()));
}

Future<File?> pickImage(BuildContext context,
    {bool multiPhotos = false}) async {
  File? image;

  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showToast(context, "حدث خطأ ما $e");
  }
  return image;
}

Future<String> storeFileToStorage(String ref, File file) async {
  UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();

  return downloadUrl;
}

//---------------------------------------------------------
 String getHouseStatusInArabic(String engStatus) {
/*
sent - أرسل النموذج من المستخدم للوحة التحكم
inReview - تتم المراجعة
accepted - تم القبول
rejected - تم الرفض
*/
    if (engStatus == "inReview") {
      return "قيد المراجعة";
    } else if (engStatus == "accepted") {
      return "تم القبول";
    } else if (engStatus == "rejected") {
      return "مرفوض";
    } else if (engStatus == "sent") {
      return "تم الإرسال";
    } else {
      return "غير معروف";
    }
  }

