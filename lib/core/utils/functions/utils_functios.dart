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

Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showToast(context, e.toString());
  }
  return image;
}

Future<String> storeFileToStorage(String ref, File file) async {
  UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();

  return downloadUrl;
}
