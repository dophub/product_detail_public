import 'dart:convert';

ResponseErrorModel responseErrorModelFromJson(String str) => ResponseErrorModel.fromJson(json.decode(str));

String responseErrorModelToJson(ResponseErrorModel data) => json.encode(data.toJson());

/// Response Error Model
class ResponseErrorModel {
  ResponseErrorModel({
    this.detail,
  });

  List<Detail>? detail;

  factory ResponseErrorModel.fromJson(Map<String, dynamic> json) => ResponseErrorModel(
    detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "detail": List<dynamic>.from(detail!.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    this.loc,
    this.msg,
    this.type,
  });

  List<String>? loc;
  String? msg;
  String? type;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    loc: List<String>.from(json["loc"].map((x) => x)),
    msg: json["msg"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "loc": List<dynamic>.from(loc!.map((x) => x)),
    "msg": msg,
    "type": type,
  };
}
