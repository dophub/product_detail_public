import 'dart:convert';
import 'dart:typed_data';

abstract class IBaseModel<T> {
  Future<T> fromJson(Map<dynamic, dynamic> json);

  Future<T> fromJsonList(List<dynamic> map);

  dynamic jsonParser(Uint8List bodyBytes) async {
    final jsonBody = json.decode(utf8.decode(bodyBytes));
    if (jsonBody is List) {
      //return await jsonBody.map((e) => fromJson(e)).toList().cast<T>();
      return await fromJsonList(jsonBody);
    }
    else if (jsonBody is Map) {
      return await fromJson(jsonBody);
    } else {
      return jsonBody;
    }
  }
}
/*

abstract class IBaseModel<T> {
  T fromJson(Map<dynamic, dynamic> map);

  T fromJsonList(List<dynamic> map);

  dynamic jsonParser(Uint8List bodyBytes) async {
    final jsonBody = json.decode(utf8.decode(bodyBytes));
    if (jsonBody is List) {
      return await fromJsonList(jsonBody);
    } else if (jsonBody is Map) {
      return await fromJson(jsonBody);
    } else
      return jsonBody;
  }
}



  @override
  fromJson(Map<dynamic, dynamic> map) async {
    return await compute(parse, map);
  }

  static parse(map) {
    return ProductDetailModel.fromJson(map);
  }

  */
