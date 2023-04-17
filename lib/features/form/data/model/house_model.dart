class HouseModel {
  String houseType;
  String houseId;
  String houseColors;
  String houseDesc;
  String userId;
  String houseLocation;
  String houseArea;
  String housePrice;
  String houseState;
  String date;
  List houseImages;

  HouseModel(
      {required this.houseId,
      required this.houseType,
      required this.houseArea,
      required this.houseColors,
      required this.houseDesc,
      required this.date,
      required this.houseImages,
      required this.houseLocation,
      required this.housePrice,
      this.houseState = "sent",
      required this.userId});

  //from map
  factory HouseModel.fromMap(Map<String, dynamic> map) {
    return HouseModel(
      houseId: map["houseId"] ?? "",
      date: map["date"] ?? "",
      houseType: map["houseType"] ?? "",
      houseArea: map["houseArea"] ?? "",
      userId: map["userId"] ?? "",
      houseColors: map["houseColors"] ?? "",
      houseDesc: map["houseDesc"] ?? "",
      houseImages: map['houseImages'] ?? List.from(map['houseImages']),
      houseLocation: map["houseLocation"] ?? "",
      housePrice: map["housePrice"] ?? "",
      houseState: map["houseState"] ?? "",
    );
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      "houseId": houseId,
      "date": date,
      "houseType": houseType,
      "houseArea": houseArea,
      "userId": userId,
      "houseColors": houseColors,
      "houseDesc": houseDesc,
      "houseImages": houseImages,
      "houseLocation": houseLocation,
      "housePrice": housePrice,
      "houseState": houseState,
    };
  }
}
