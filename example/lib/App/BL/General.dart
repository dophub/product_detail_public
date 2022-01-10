import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:example/App/Model/BaseHttpModel.dart';
import 'package:flutter/foundation.dart';
import 'package:example/Core/Service/HttpClient.dart';
import 'package:example/App/Constant/App/HttpUrl.dart';
import 'package:example/App/Constant/Enums/LoadingStatusEnum.dart';
import 'package:sip_models/sip_general_models.dart';
import 'package:sip_models/sip_response_models.dart';

/// Tüm moldüllerde ile kullanılan Http işlemleri burada yapılmakta
///
class General {

  Map<String,String> getHeader() => {'authorization':'Bearer ' + HttpUrl.token};

  /// Token çekmek için yazıldı
  Future<BaseHttpModel<TokenModel>> getToken(String userSsoId) async {
    try {
      Map<String, String> map = {
        'apikey': HttpUrl.apiKey,
        'secretkey': HttpUrl.secretKey,
        'client': describeEnum(HttpUrl.clientId),
        'sessionid': userSsoId,
      };
      var response = await HttpClient().get(HttpUrl.getToken, header: map);
      if (response!.statusCode == HttpStatus.ok) {
        TokenModel responseModel = TokenModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        return BaseHttpModel<TokenModel>(status: BaseModelStatus.Ok, data: responseModel);
      } else {
        return BaseHttpModel<TokenModel>(status: BaseModelStatus.Error);
      }
    } catch (e) {
      log(e.toString(),name: 'Api Error getToken');
      return BaseHttpModel<TokenModel>(status: BaseModelStatus.Error);
    }
  }

  /// Ürün detayı çekmek için yazıldı
  /// [getProductDetail] Ürün detayını çekmek için yazıldı
  Future<BaseHttpModel> getProductDetail<T extends IBaseModel>(T model,int dealerId, int productId) async {
    try {
      var response = await HttpClient().get(HttpUrl.getProductDetails, body: '$dealerId/$productId', header: getHeader());
      if (response!.statusCode == HttpStatus.ok) {
        ProductDetailModel responseModel = await model.jsonParser(response.bodyBytes);
        return BaseHttpModel(status: BaseModelStatus.Ok, data: responseModel);
      } else if (response.statusCode == HttpStatus.unprocessableEntity) {
        ResponseErrorModel responseModel = ResponseErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        return BaseHttpModel(status: BaseModelStatus.Ok, data: responseModel);
      } else {
        return BaseHttpModel(status: BaseModelStatus.Error);
      }
    } catch (e) {
      log(e.toString(),name: 'Api Error getProductDetail');
      return BaseHttpModel(status: BaseModelStatus.Error);
    }
  }

  /// Ürün detayı çekmek için yazıldı
  /// [getPromotionDetail] Promosyonlu ürün detayını çekmek için yazıldı
  Future<BaseHttpModel> getPromotionDetail<T extends IBaseModel>(T model,int dealerId, int productId) async {
    try {
      var response = await HttpClient().get(HttpUrl.getPromotionMenu, body: '$dealerId/$productId', header: getHeader());
      if (response!.statusCode == HttpStatus.ok) {
        PromotionMenuDetailModel responseModel = await model.jsonParser(response.bodyBytes);
        return BaseHttpModel(status: BaseModelStatus.Ok, data: responseModel);
      } else if (response.statusCode == HttpStatus.unprocessableEntity) {
        ResponseErrorModel responseModel = ResponseErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        return BaseHttpModel(status: BaseModelStatus.Ok, data: responseModel);
      }  else {
        return BaseHttpModel(status: BaseModelStatus.Error);
      }
    } catch (e) {
      log(e.toString(),name: 'Api Error getPromotionDetail');
      return BaseHttpModel(status: BaseModelStatus.Error);
    }
  }

}

