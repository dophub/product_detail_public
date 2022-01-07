import 'dart:convert';
import 'dart:typed_data';

abstract class IBaseModel<T> {
  T fromJson(Map<dynamic, dynamic> json);

  Future<T> fromJsonInBackground(Uint8List bodyBytes);

  dynamic jsonParser(Uint8List bodyBytes) {
    final jsonBody = json.decode(utf8.decode(bodyBytes));
    if (jsonBody is List) {
      return jsonBody.map((e) => fromJson(e)).toList().cast<T>();
    } else if (jsonBody is Map) {
      return fromJson(jsonBody);
    } else {
      return jsonBody;
    }
  }

  dynamic backgroundJsonParser(Uint8List bodyBytes) async {
    return await fromJsonInBackground(bodyBytes);
  }
}
