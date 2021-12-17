import 'dart:convert';
import 'package:example/App/Model/General/IBaseModel.dart';
import 'package:product_detail/model.dart';

ServiceModel serviceModelFromJson(String str) => ServiceModel().fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

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

  ServiceModel fromJson(Map<dynamic, dynamic> json) => ServiceModel(
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
            json["orders"].map((x) => OrderModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "table_id": tableId,
        "service_number": serviceNumber,
        "person_count": personCount,
        "revision_number": revisionNumber,
        "total_tip_amount": totalTipAmount,
        "dealer_id": dealerId,
        "pay_customer_id": payCustomerId,
        "payment_type_id": paymentTypeId,
        "service_pay_type_id": servicePayTypeId,
        "service_total_amount": serviceTotalAmount,
        "service_total_amount_without_kdv": serviceTotalAmountWithoutKdv,
        "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}
