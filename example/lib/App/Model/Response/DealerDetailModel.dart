import 'dart:convert';

import 'category_widget_model.dart';



DealerDetailModel dealerDetailModelFromJson(String str) =>
    DealerDetailModel.fromJson(json.decode(str));

String dealerDetailModelToJson(DealerDetailModel data) =>
    json.encode(data.toJson());

/// GR Kod okutulduğu zaman Api den dönen Response
class DealerDetailModel {
  DealerDetailModel({
    this.dealerId,
    this.mainBrandId,
    this.dealerName,
    this.table,
    this.workingHours,
    this.logo,
    this.banner,
    this.menus,
    this.categories,
  });

  int? dealerId;
  int? mainBrandId;
  String? dealerName;
  TableModel? table;
  List<WorkingHourModel>? workingHours;
  String? logo;
  String? banner;
  List<MenuModel>? menus;
  List<CategoryWidgetModel>? categories;

  factory DealerDetailModel.fromJson(Map<String, dynamic> json) =>
      DealerDetailModel(
        dealerId: json["dealer_id"],
        mainBrandId: json["main_brand_id"],
        dealerName: json["dealer_name"],
        table: TableModel.fromJson(json["tables"]),
        workingHours: List<WorkingHourModel>.from( json["working_hours"].map((x) => WorkingHourModel.fromJson(x))),
        logo: json["logo"],
        banner: json["banner"],
        menus: json["menus"] == null ? [] : List<MenuModel>.from(json["menus"].map((x) => MenuModel.fromJson(x))),
        categories: json["categories"] == null ? [] : List<CategoryWidgetModel>.from(json["categories"].map((x) => CategoryWidgetModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dealer_id": dealerId,
        "main_brand_id": mainBrandId,
        "dealer_name": dealerName,
        "tables": table!.toJson(),
        "working_hours":
            List<dynamic>.from(workingHours!.map((x) => x.toJson())),
        "logo": logo,
        "banner": banner,
        "menus": List<dynamic>.from(menus!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}



/// Okutulan masa bilgileri
class TableModel {
  TableModel({
    this.tableCode,
    this.tableName,
    this.stationCode,
  });

  String? tableCode;
  String? tableName;
  String? stationCode;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        tableCode: json["table_code"],
        tableName: json["table_name"],
        stationCode: json["station_code"],
      );

  Map<String, dynamic> toJson() => {
        "table_code": tableCode,
        "table_name": tableName,
        "station_code": stationCode,
      };
}

class MenuModel {
  MenuModel({
    this.id,
    this.menuName,
    this.menuImage,
    this.menuOrder,
  });

  int? id;
  String? menuName;
  String? menuImage;
  int? menuOrder;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    id: json["id"],
    menuName: json["menu_name"],
    menuImage: json["menu_image"],
    menuOrder: json["menu_order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menu_name": menuName,
    "menu_image": menuImage,
    "menu_order": menuOrder,
  };
}

/// İşleteme çalışma saatleri
class WorkingHourModel {
  WorkingHourModel({
    this.end,
    this.start,
    this.title,
    this.status,
    this.courier,
    this.dayofweek,
    this.courierEnd,
    this.courierStart,
  });

  String? end;
  String? start;
  String? title;
  bool? status;
  bool? courier;
  String? dayofweek;
  String? courierEnd;
  String? courierStart;

  factory WorkingHourModel.fromJson(Map<String, dynamic> json) =>
      WorkingHourModel(
        end: json["end"],
        start: json["start"],
        title: json["title"],
        status: json["status"],
        courier: json["courier"],
        dayofweek: json["dayofweek"],
        courierEnd: json["courier_end"],
        courierStart: json["courier_start"],
      );

  Map<String, dynamic> toJson() => {
        "end": end,
        "start": start,
        "title": title,
        "status": status,
        "courier": courier,
        "dayofweek": dayofweek,
        "courier_end": courierEnd,
        "courier_start": courierStart,
      };
}
