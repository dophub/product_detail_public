import 'dart:convert';
import 'dart:typed_data';

abstract class IBaseModel<T> {
  Future<T> fromJson(Map<dynamic, dynamic> json);

  Future<T> fromJsonList(List<dynamic> map);

  dynamic jsonParser(Uint8List bodyBytes) async {
    final jsonBody = json.decode(utf8.decode(bodyBytes));
    if (jsonBody is List) {
      return await fromJsonList(jsonBody);
    }
    else if (jsonBody is Map) {
      return await fromJson(jsonBody);
    } else {
      return jsonBody;
    }
  }
}
