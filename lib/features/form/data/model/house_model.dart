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
  int roomsCount;
  int toiletCount;
  int kitchenCount;
  int minRentPeriod;
  int numberOfStars;
  bool wifi;
  bool elec;
  bool furniture;
  bool water;

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
      required this.elec,
      required this.water,
      required this.furniture,
      required this.kitchenCount,
      required this.minRentPeriod,
      this.numberOfStars = 1,
      required this.roomsCount,
      required this.toiletCount,
      required this.wifi,
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
      elec: map["elec"] ?? "",
      furniture: map["furniture"] ?? "",
      kitchenCount: map["kitchenCount"] ?? "",
      minRentPeriod: map["minRentPeriod"] ?? "",
      roomsCount: map["roomsCount"] ?? "",
      toiletCount: map["toiletCount"] ?? "",
      water: map["water"] ?? "",
      wifi: map["wifi"] ?? "",
      numberOfStars: map["numberOfStars"] ?? "",
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
      "elec": elec,
      "furniture": furniture,
      "kitchenCount": kitchenCount,
      "minRentPeriod": minRentPeriod,
      "roomsCount": roomsCount,
      "toiletCount": toiletCount,
      "water": water,
      "wifi": wifi,
      "numberOfStars": numberOfStars,
    };
  }
}
