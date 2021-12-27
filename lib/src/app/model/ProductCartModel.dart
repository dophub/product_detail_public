import 'dart:convert';
import 'package:product_detail/src/app/model/OrderModel.dart';


ProductCartModel productCartModelFromJson(String? str) => ProductCartModel.fromJson(json.decode(str!));

String? productCartModelToJson(ProductCartModel data) => json.encode(data.toJson());

/// Sepete modelini temsil etmekte
class ProductCartModel {
  ProductCartModel({
    this.serviceId,
    this.tableId,
    this.serviceNumber,
    this.totalAmount,
    this.payTypeId,
    this.dealerId,
    this.paymentTypeId,
    this.payCustomer,
    this.orders,
  });

  int? serviceId;
  String? tableId;
  String? serviceNumber;
  double? totalAmount;
  String? payTypeId;
  int? dealerId;
  String? paymentTypeId;
  Customer? payCustomer;
  List<Order>? orders;

  factory ProductCartModel.fromJson(Map<String?, dynamic> json) => ProductCartModel(
    serviceId: json["service_id"],
    tableId: json["table_id"],
    serviceNumber: json["service_number"],
    totalAmount: json["total_amount"].toDouble(),
    payTypeId: json["pay_type_id"],
    dealerId: json["dealer_id"],
    paymentTypeId: json["payment_type_id"],
    payCustomer: Customer.fromJson(json["customer"]),
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "service_id": serviceId,
    "table_id": tableId,
    "service_number": serviceNumber,
    "total_amount": totalAmount,
    "pay_type_id": payTypeId,
    "dealer_id": dealerId,
    "payment_type_id": paymentTypeId,
    "pay_customer": payCustomer!.toJson(),
    "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

/// Sepete içinde olan siparisler
class Order {
  Order({
    this.id,
    this.customer,
    this.orderNumber,
    this.totalAmount,
    this.orderNote,
    this.orderPointId,
    this.sessionPointId,
    this.paymentTypeId,
    this.deliveryTypeId,
    this.customerAddress,
    this.deliveryTimeId,
    this.deliveryDate,
    this.tipAmount,
    this.dealerId,
    this.clientPointId,
    this.orderStatus,
    this.orderOptions,
    this.items,
  });

  int? id;
  Customer? customer;
  String? orderNumber;
  double? totalAmount;
  String? orderNote;
  String? orderPointId;
  String? sessionPointId;
  String? paymentTypeId;
  String? deliveryTypeId;
  CustomerAddress? customerAddress;
  String? deliveryTimeId;
  String? deliveryDate;
  double? tipAmount;
  int? dealerId;
  String? clientPointId;
  OrderStatus? orderStatus;
  List<OrderOptionModel>? orderOptions;
  List<ItemOrder>? items;

  factory Order.fromJson(Map<String?, dynamic> json) => Order(
    id: json["id"],
    customer: Customer.fromJson(json["customer"]),
    orderNumber: json["order_number"],
    totalAmount: json["total_amount"].toDouble(),
    orderNote: json["order_note"],
    orderPointId: json["order_point_id"],
    sessionPointId: json["session_point_id"],
    paymentTypeId: json["payment_type_id"],
    deliveryTypeId: json["delivery_type_id"],
    customerAddress: CustomerAddress.fromJson(json["customer_address"]),
    deliveryTimeId: json["delivery_time_id"],
    deliveryDate: json["delivery_date"],
    tipAmount: json["tip_amount"].toDouble(),
    dealerId: json["dealer_id"],
    clientPointId: json["client_point_id"],
    orderStatus: OrderStatus.fromJson(json["order_status"]),
    orderOptions: List<OrderOptionModel>.from(json["order_options"].map((x) => OrderOptionModel.fromJson(x))),
    items: List<ItemOrder>.from(json["items"].map((x) => ItemOrder.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "customer": customer!.toJson(),
    "order_number": orderNumber,
    "total_amount": totalAmount,
    "order_note": orderNote,
    "order_point_id": orderPointId,
    "session_point_id": sessionPointId,
    "payment_type_id": paymentTypeId,
    "delivery_type_id": deliveryTypeId,
    "customer_address": customerAddress!.toJson(),
    "delivery_time_id": deliveryTimeId,
    "delivery_date": deliveryDate,
    "tip_amount": tipAmount,
    "dealer_id": dealerId,
    "client_point_id": clientPointId,
    "order_status": orderStatus!.toJson(),
    "order_options": List<dynamic>.from(orderOptions!.map((x) => x.toJson())),
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Customer {
  Customer({
    this.id,
    this.nameSurname,
    this.sessionId,
    this.nickName,
  });

  int? id;
  String? nameSurname;
  String? sessionId;
  String? nickName;

  factory Customer.fromJson(Map<String?, dynamic> json) => Customer(
    id: json["id"],
    nameSurname: json["name_surname"],
    sessionId: json["sessionId"],
    nickName: json["nick_name"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "name_surname": nameSurname,
    "sessionId": sessionId,
    "nick_name": nickName,
  };
}


class CustomerAddress {
  CustomerAddress({
    this.id,
    this.floor,
    this.latlng,
    this.address,
    this.cityId,
    this.cityName,
    this.districtId,
    this.flatNumber,
    this.addressName,
    this.addressRoute,
    this.districtName,
    this.buildingNumber,
    this.neighborhoodId,
    this.neighborhoodName,
  });

  int? id;
  String? floor;
  String? latlng;
  String? address;
  int? cityId;
  String? cityName;
  int? districtId;
  String? flatNumber;
  String? addressName;
  String? addressRoute;
  String? districtName;
  String? buildingNumber;
  int? neighborhoodId;
  String? neighborhoodName;

  factory CustomerAddress.fromJson(Map<String, dynamic> json) => CustomerAddress(
    id: json["id"],
    floor: json["floor"],
    latlng: json["latlng"],
    address: json["address"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    districtId: json["district_id"],
    flatNumber: json["flat_number"],
    addressName: json["address_name"],
    addressRoute: json["address_route"],
    districtName: json["district_name"],
    buildingNumber: json["building_number"],
    neighborhoodId: json["neighborhood_id"],
    neighborhoodName: json["neighborhood_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "floor": floor,
    "latlng": latlng,
    "address": address,
    "city_id": cityId,
    "city_name": cityName,
    "district_id": districtId,
    "flat_number": flatNumber,
    "address_name": addressName,
    "address_route": addressRoute,
    "district_name": districtName,
    "building_number": buildingNumber,
    "neighborhood_id": neighborhoodId,
    "neighborhood_name": neighborhoodName,
  };
}

/// List olup her biri bi ürünü temsil etmekte
class ItemOrder {
  ItemOrder({
    required this.id,
    this.itemType,
    this.count,
    this.itemAmount,
    this.totalAmount,
    this.product,
    this.promotionMenu,
    this.note,
    this.timeoutAction,
  });

  /// Order içinde itemleri ayırmak için olan id.
  /// Örneğin aynı ürün olup ama özellikleri farklı seçilen iki tane aynı üründen olduğunda
  /// bu durumda order içinde iki farklı ürün olup ürün id [item_id] leri aynı olup ama id leri farklı olur
  int id;
  String? itemType;
  int? count;
  double? itemAmount;
  double? totalAmount;
  Product? product;
  PromotionMenu? promotionMenu;
  String? note;
  String? timeoutAction;

  factory ItemOrder.fromJson(Map<String?, dynamic> json) => ItemOrder(
    id: json["id"],
    itemType: json["item_type"],
    count: json["count"],
    itemAmount: json["item_amount"].toDouble(),
    totalAmount: json["total_amount"].toDouble(),
    note: json["note"],
    product: Product.fromJson(json["product"]),
    promotionMenu: PromotionMenu.fromJson(json["promotion_menu"]),
    timeoutAction: json["timeout_action"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_type": itemType,
    "count": count,
    "item_amount": itemAmount,
    "total_amount": totalAmount,
    "note": note,
    "product": product == null ? null :product!.toJson(),
    "promotion_menu": promotionMenu == null ? null :promotionMenu!.toJson(),
    "timeout_action": timeoutAction,
  };
}

class Product {
  Product({
    this.itemId,
    this.productName,
    this.options,
  });

  int? itemId;
  String? productName;
  List<Options>? options;

  factory Product.fromJson(Map<String?, dynamic> json) => Product(
    itemId: json["item_id"],
    productName: json["product_name"],
    options: json["options"] == null ? [] :List<Options>.from(json["options"].map((x) => Options.fromJson(x))),

  );

  Map<String?, dynamic> toJson() => {
    "item_id": itemId,
    "product_name": productName,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Options {
  Options({
    this.optionType,
    this.id,
    this.title,
    this.addingType,
    this.totalPrice,
    this.items,
  });

  String? optionType;
  int? id;
  String? title;
  String? addingType;
  double? totalPrice;
  List<Items>? items;

  factory Options.fromJson(Map<String?, dynamic> json) => Options(
    optionType: json["option_type"],
    id: json["id"],
    title: json["title"],
    addingType: json["adding_type"],
    totalPrice: json["total_price"].toDouble(),
    items: List<Items>.from(json["items"].map((x) => Items.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "option_type": optionType,
    "id": id,
    "title": title,
    "adding_type": addingType,
    "total_price": totalPrice,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Items {
  Items({
    this.id,
    this.title,
    this.productId,
    this.price,
  });

  int? id;
  String? title;
  int? productId;
  double? price;

  factory Items.fromJson(Map<String?, dynamic> json) => Items(
    id: json["id"],
    title: json["title"],
    productId: json["product_id"],
    price: json["price"].toDouble(),
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "title": title,
    "product_id": productId,
    "price": price,
  };
}

class PromotionMenu {
  PromotionMenu({
    this.itemId,
    this.promotionName,
    this.sections,
  });

  int? itemId;
  String? promotionName;
  List<Section>? sections;

  factory PromotionMenu.fromJson(Map<String?, dynamic> json) => PromotionMenu(
    itemId: json["item_id"],
    promotionName: json["promotion_name"],
    sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "item_id": itemId,
    "promotion_name": promotionName,
    "sections": List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}

class Section {
  Section({
    this.sectionId,
    this.sectionTitle,
    this.sectionItem,
  });

  int? sectionId;
  String? sectionTitle;
  Product? sectionItem;

  factory Section.fromJson(Map<String?, dynamic> json) => Section(
    sectionId: json["section_id"],
    sectionTitle: json["section_title"],
    sectionItem: Product.fromJson(json["section_item"]),
  );

  Map<String?, dynamic> toJson() => {
    "section_id": sectionId,
    "section_title": sectionTitle,
    "section_item": sectionItem!.toJson(),
  };
}

class OrderOptionModel {
  OrderOptionModel({
    this.optionCode,
    this.optionName,
  });

  String? optionCode;
  String? optionName;

  factory OrderOptionModel.fromJson(Map<String?, dynamic> json) => OrderOptionModel(
    optionCode: json["option_code"],
    optionName: json["option_name"],
  );

  Map<String?, dynamic> toJson() => {
    "option_code": optionCode,
    "option_name": optionName,
  };
}


