import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:product_detail/model.dart';



/// Dealer de adisyon için kullanılmakta
class ServiceModel extends IBaseModel<ServiceModel>{
  ServiceModel({
    this.serviceId,
    this.tableId,
    this.serviceNumber,
    this.personCount,
    this.revisionNumber,
    this.totalTipAmount,
    this.dealerId,
    this.payCustomerId,
    this.paymentTypeId,
    this.servicePayTypeId,
    this.serviceTotalAmount,
    this.serviceTotalAmountWithoutKdv,
    this.orders,
  });

  int? serviceId;
  String? tableId;
  String? serviceNumber;
  int? personCount;
  String? revisionNumber;
  int? totalTipAmount;
  int? dealerId;
  int? payCustomerId;
  String? paymentTypeId;
  String? servicePayTypeId;
  double? serviceTotalAmount;
  double? serviceTotalAmountWithoutKdv;
  List<OrderModel>? orders;

  factory ServiceModel.fromJson(Map<dynamic, dynamic> json) => ServiceModel(
        serviceId: json["service_id"],
        tableId: json["table_id"],
        serviceNumber: json["service_number"],
        personCount: json["person_count"],
        revisionNumber: json["revision_number"],
        totalTipAmount: json["total_tip_amount"],
        dealerId: json["dealer_id"],
        payCustomerId: json["pay_customer_id"],
        paymentTypeId: json["payment_type_id"],
        servicePayTypeId: json["service_pay_type_id"],
        serviceTotalAmount: json["service_total_amount"].toDouble(),
        serviceTotalAmountWithoutKdv:
            json["service_total_amount_without_kdv"].toDouble(),
        orders: List<OrderModel>.from(
            json["orders"].map((x) => OrderModel().fromJson(x))),
      );

  @override
  Future<ServiceModel> fromJson(Map json) async {
    return await compute(parse, json);
  }

  static ServiceModel parse(map) {
    return ServiceModel.fromJson(map);
  }

  @override
  Future<ServiceModel> fromJsonList(List map) async {
    // TODO: implement fromJsonList
    throw UnimplementedError();
  }
}
