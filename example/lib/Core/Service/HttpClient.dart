import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../App/Constant/App/HttpUrl.dart';

/// written this class for http client
///
class HttpClient {

  /// http get method
  /// [body] Request body
  /// [apiParameters] Request body e dönştürülecek
  /// [body] var ise body body olarak geçerli olacak null ise [apiParameters] yi alıp dönüştürecek
  Future<http.Response?> get(String method, {Map<String, dynamic> apiParameters = const {}, required Map<String, String>? header, String body = ''}) async {
    //if there is internet
    if (body == '' && apiParameters.length != 0) {
      var bodyValue = '';
      //we convert the parameters in maps to get mathod
      apiParameters.forEach((key, value) {
        bodyValue += '&' + key.toString() + '=' + value.toString();
      });
      //we delete the first character
      if (bodyValue != '') bodyValue = bodyValue.substring(1);
      bodyValue = bodyValue.replaceAll('(', '');
      bodyValue = bodyValue.replaceAll(')', '');
      body = '?' + bodyValue;
    } else if (body != '') {
      body = '/' + body;
    }
    _logS(HttpUrl.baseUrl + method, header);
    // Sends an HTTP get
    var response = await http.get(Uri.parse(HttpUrl.baseUrl + method + body),
        headers: header);
    _logE(response.body);
    return response;
  }

  /// http post method
  Future<http.Response?> post(String method, {required Map<String, dynamic> apiParameters, required Map<String, String>? header}) async {
    //we convert the map to json
    var encodedBody = json.encode(apiParameters);
    _logS(HttpUrl.baseUrl + method, header);
    // Sends an HTTP POST
    var response = await http.post(Uri.parse(HttpUrl.baseUrl + method),
        headers: header,
        body: encodedBody,
        encoding: Encoding.getByName("application/json"));
    _logE(response.body);
    //returns the resulting Json object.
    return response;
  }

  /// http delete method
  Future<http.Response?> delete(String method, {Map<String, dynamic> apiParameters = const {}, required Map<String, String>? header}) async {
    var encodedBody = json.encode(apiParameters);
    _logS(HttpUrl.baseUrl + method, header);
    var response = await http.delete(Uri.parse(HttpUrl.baseUrl + method), body: encodedBody, headers: header);
    _logE(response.body);
    return response;
  }

  /// http put method
  Future<http.Response?> put(String method, {required Map<String, dynamic> apiParameters, required Map<String, String>? header}) async {
    //we convert the map to json
    var encodedBody = json.encode(apiParameters);
    _logS(HttpUrl.baseUrl + method, header);
    // Sends an HTTP put
    var response = await http.put(Uri.parse(HttpUrl.baseUrl + method),
        headers: header,
        body: encodedBody,
        encoding: Encoding.getByName("application/json"));
    //returns the resulting Json object.
    _logE(response.body);
    return response;
  }

  /// http put method
  Future<http.Response?> update(String method, {required Map<String, dynamic> apiParameters, required Map<String, String>? header}) async {
    //we convert the map to json
    var encodedBody = json.encode(apiParameters);
    _logS(HttpUrl.baseUrl + method, header);
    // Sends an HTTP put
    var response = await http.post(Uri.parse(HttpUrl.baseUrl + method),
        headers: header,
        body: encodedBody,
        encoding: Encoding.getByName("application/json"));
    _logE(response.body);
    return response;
  }

  void _logS(String url,Map<String,String>? header){
    log('______________________________________________________________________',name: 'Http Start');
    log(url,name: 'Api Request Url');
    log(jsonEncode(header),name: 'Header');
  }

  void _logE(String responseBody){
    log(responseBody,name: 'Rsponse');
    log('______________________________________________________________________',name: 'Http End',);
  }
}
