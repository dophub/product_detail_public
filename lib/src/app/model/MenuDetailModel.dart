import 'dart:convert';
import 'ImagesModel.dart';
import 'PriceModel.dart';

MenuDetailModel menuDetailModelFromJson(String str) => MenuDetailModel.fromJson(json.decode(str));

String menuDetailModelToJson(MenuDetailModel data) => json.encode(data.toJson());

List<MenuProductModel> productListModelFromJson(String str) => List<MenuProductModel>.from(json.decode(str).map((x) => MenuProductModel.fromJson(x)));

/// Menü ye tılandığı zaman Api den gelen Response için kullanılmakta
class MenuDetailModel {
  MenuDetailModel({
    this.id,
    this.menuName,
    this.categories,
  });


  int? id;
  String? menuName;
  List<MenuDetailCategoryModel>? categories;

  factory MenuDetailModel.fromJson(Map<String, dynamic> json) =>
      MenuDetailModel(
        id: json["id"],
        menuName: json["menu_name"],
        categories: List<MenuDetailCategoryModel>.from(
            json["categories"].map((x) => MenuDetailCategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "menu_name": menuName,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class MenuDetailCategoryModel {
  MenuDetailCategoryModel({
    this.id,
    this.products,
    this.listOrder,
    this.categoryName,
    this.menuListTypeId,
  });

  MenuDetailCategoryModel.clone(MenuDetailCategoryModel obj)
      : this(
          id: obj.id,
          products: obj.products,
          listOrder: obj.listOrder,
          categoryName: obj.categoryName,
          menuListTypeId: obj.menuListTypeId,
        );

  int? id;
  List<MenuProductModel>? products;
  int? listOrder;
  String? categoryName;
  String? menuListTypeId;

  factory MenuDetailCategoryModel.fromJson(Map<String, dynamic> json) =>
      MenuDetailCategoryModel(
        id: json["id"],
        products: json["products"] == null ? []: List<MenuProductModel>.from(json["products"].map((x) => MenuProductModel.fromJson(x))),
        listOrder: json["list_order"],
        categoryName: json["category_name"],
        menuListTypeId: json["menu_list_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "list_order": listOrder,
        "category_name": categoryName,
        "menu_list_type_id": menuListTypeId,
      };
}

/// Menu va kategori modelerde olan ürün biligileri
class MenuProductModel {
  MenuProductModel({
    this.id,
    this.price,
    this.images,
    this.calorie,
    this.itemType,
    this.makeTime,
    this.listOrder,
    this.optionCount,
    this.productName,
    this.shortDescription,
  });

  int? id;
  List<PriceModel>? price;
  List<ImagesModel>? images;
  int? calorie;
  String? itemType;
  int? makeTime;
  int? listOrder;
  int? optionCount;
  String? productName;
  String? shortDescription;

  factory MenuProductModel.fromJson(Map<String, dynamic> json) => MenuProductModel(
        id: json["id"],
        price: List<PriceModel>.from(json["price"].map((x) => PriceModel.fromJson(x))),
        images: json["images"] == null ? []:List<ImagesModel>.from(json["images"].map((x) => ImagesModel.fromJson(x))),
        calorie: json["calorie"] ?? 0,
        itemType: json["item_type"],
        makeTime: json["make_time"] ?? 0,
        listOrder: json["list_order"],
        optionCount: json["option_count"],
        productName: json["product_name"],
        shortDescription: json["short_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": List<dynamic>.from(price!.map((x) => x.toJson())),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "calorie": calorie,
        "item_type": itemType,
        "make_time": makeTime,
        "list_order": listOrder,
        "option_count": optionCount,
        "product_name": productName,
        "short_description": shortDescription,
      };
}
