import 'dart:convert';


import 'package:product_detail/src/app/model/IBaseModel.dart';

import 'ImagesModel.dart';
import 'MenuDetailModel.dart';
import 'PriceModel.dart';
import 'ProductDetailModel.dart';

PromotionMenuModel promotionMenuModelFromJson(String str) => PromotionMenuModel.fromJson(json.decode(str));

String promotionMenuModelToJson(PromotionMenuModel data) => json.encode(data.toJson());

/// PromotionProfileScreende kullanılam promosyonlu ürün detay modelidir
class PromotionMenuModel extends IBaseModel<PromotionMenuModel>{
  PromotionMenuModel({
    this.id,
    this.totalCalorie,
    this.totalTime,
    this.promotionMenuName,
    this.shortDescription,
    this.description,
    this.images,
    this.price,
    this.sections,
  });

  int? id;
  int? totalCalorie;
  int? totalTime;
  String? promotionMenuName;
  String? shortDescription;
  String? description;
  List<ImagesModel>? images;
  List<PriceModel>? price;
  List<SectionModel>? sections;



  factory PromotionMenuModel.fromJson(Map<dynamic, dynamic> json) => PromotionMenuModel(
    id: json["id"],
    totalCalorie: json["total_calorie"],
    totalTime: json["total_time"],
    promotionMenuName: json["promotion_menu_name"],
    shortDescription: json["short_description"],
    description: json["description"],
      images: json["images"] == null ? []:List<ImagesModel>.from(json["images"].map((x) => ImagesModel.fromJson(x))),
    price: json["price"] == null ? [] : List<PriceModel>.from(json["price"].map((x) => PriceModel.fromJson(x))),
    sections: json["sections"] == null ? [] : List<SectionModel>.from(json["sections"].map((x) => SectionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_calorie": totalCalorie,
    "total_time": totalTime,
    "promotion_menu_name": promotionMenuName,
    "short_description": shortDescription,
    "description": description,
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    "price": List<PriceModel>.from(price!.map((x) => x.toJson())),
    "sections": List<SectionModel>.from(sections!.map((x) => x.toJson())),
  };


  @override
  Future<PromotionMenuModel> fromJsonList(List map) {
    // TODO: implement fromJsonList
    throw UnimplementedError();
  }

  @override
  Future<PromotionMenuModel> fromJson(Map json) async {
    return PromotionMenuModel.fromJson(json);
  }
}

/// Promosyon ürünleri Sectionidir
class SectionModel {
  SectionModel({
    this.id,
    this.products,
    this.listOrder,
    this.description,
    this.sectionName,
    this.chooseRequired,
    this.isSelected = false,
  });

  int? id;
  List<ProductDetailModel>? products;
  int? listOrder;
  String? description;
  String? sectionName;
  bool? chooseRequired;
  bool isSelected;

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
    id: json["id"],
    products: json["products"] == null ? [] : List<ProductDetailModel>.from(json["products"].map((x) => ProductDetailModel.fromJson(x))),
    listOrder: json["list_order"],
    description: json["description"],
    sectionName: json["section_name"],
    chooseRequired: json["choose_required"],
  );



  Map<String, dynamic> toJson() => {
    "id": id,
    "products": List<MenuProductModel>.from(products!.map((x) => x.toJson())),
    "list_order": listOrder,
    "description": description,
    "section_name": sectionName,
    "choose_required": chooseRequired,
  };
}







