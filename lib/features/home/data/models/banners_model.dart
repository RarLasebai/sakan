class BannersModel {
  List bannersImages, ids;
  BannersModel({required this.bannersImages, required this.ids});

  factory BannersModel.fromMap(Map<String, dynamic> map) {
    return BannersModel(
      bannersImages: map["images"] ?? List.from(map["images"]),
      ids: map["ids"] ?? List.from(map["ids"])
    );
  }
}
