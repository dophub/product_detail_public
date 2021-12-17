import 'dart:convert';

List<CardsModel> cardsModelFromJson(String str) => List<CardsModel>.from(json.decode(str).map((x) => CardsModel.fromJson(x)));

String cardsModelToJson(List<CardsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardsModel {
  CardsModel({
    this.id,
    this.title,
    this.cardNo,
    this.family,
    this.association,
  });

  String? id;
  String? title;
  String? cardNo;
  String? family;
  String? association;

  factory CardsModel.fromJson(Map<String, dynamic> json) => CardsModel(
        id: json["id"],
        title: json["title"],
        cardNo: json["cardno"],
        family: json["family"],
        association: json["association"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cardno": cardNo,
        "family": family,
        "association": association,
      };
}
