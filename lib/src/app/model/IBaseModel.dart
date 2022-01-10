import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

abstract class IBaseModel<T> {
  T fromJson(Map<dynamic, dynamic> json);

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
    final port = ReceivePort();
    await Isolate.spawn(_parse, {'port':port.sendPort,'body':bodyBytes});
    return await port.first;
  }

  _parse(map) {
    final port = map['port'];
    final jsonBody = json.decode(utf8.decode(map['body']));
    late final result;
    if(jsonBody is List){
      result = jsonBody.map((e) => fromJson(e)).toList().cast<T>();
    } else if(jsonBody is Map){
      result = fromJson(jsonBody);
    } else {
      result = jsonBody;
    }
    Isolate.exit(port, result);
  }
}
