class UserModel {
  String userName;
  String userId;
  String userPhone;
  String userPassword;
  String userPersonalProof;
  String userMartialStatus;
  String userNationality;
  String userAddress;
  String userPhoto;

  UserModel(
      {required this.userName,
      required this.userId,
      required this.userPhone,
      required this.userPassword,
      required this.userPersonalProof,
      required this.userMartialStatus,
      required this.userNationality,
      required this.userAddress,
      this.userPhoto =
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"});

  //from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        userName: map["userName"] ?? "",
        userId: map["userId"] ?? "",
        userPhone: map["userPhone"] ?? "",
        userPassword: map["userPassword"] ?? "",
        userPersonalProof: map["userPersonalProof"] ?? "",
        userMartialStatus: map["userMartialStatus"] ?? "",
        userNationality: map["userNationality"] ?? "",
        userAddress: map["userAddress"] ?? "",
        userPhoto: map["userPhoto"] ?? "");
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "userId": userId,
      "userPhone": userPhone,
      "userPersonalProof": userPersonalProof,
      "userPassword": userPassword,
      "userAddress": userAddress,
      "userNationality": userNationality,
      "userMartialStatus": userMartialStatus,
      "userPhoto": userPhoto
    };
  }
}
