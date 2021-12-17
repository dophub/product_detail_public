
/// Response modellerde olan Fiyat modelini temsilö etmekte
class PriceModel {
  PriceModel({
    this.id,
    this.price,
    this.isDefault,
    this.orderDeliveryTypeId,
  });

  int? id;
  double? price;
  bool? isDefault;
  String? orderDeliveryTypeId;

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
    id: json["id"],
    price: json["price"].toDouble(),
    isDefault: json["is_default"],
    orderDeliveryTypeId: json["order_delivery_type_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "is_default": isDefault,
    "order_delivery_type_id": orderDeliveryTypeId,
  };
}
