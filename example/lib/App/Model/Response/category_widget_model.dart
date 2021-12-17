import 'dart:convert';

List<CategoryWidgetModel> categoryWidgetModelFromJson(String str) => List<CategoryWidgetModel>.from(json.decode(str).map((x) => CategoryWidgetModel.fromJson(x)));

String categoryWidgetModelToJson(List<CategoryWidgetModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

///Dealer(Kategori) ve MarketPlace(Mutfaklar) modüllerinde kullanılan model


class CategoryWidgetModel {
  CategoryWidgetModel({
    this.id,
    this.image,
    this.listOrder,
    this.categoryName,
  });

  String? id;
  String? image;
  int? listOrder;
  String? categoryName;

  factory CategoryWidgetModel.fromJson(Map<String, dynamic> jsonData) => CategoryWidgetModel(
    id: jsonData["id"].toString(),
    image: jsonData["icon_file"]["url"] ?? "",
    listOrder: jsonData["list_order"],
    categoryName: jsonData["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon_file": image,
    "list_order": listOrder,
    "category_name": categoryName,
  };
}


