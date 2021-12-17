
import 'dart:convert';

TokenModel tokenModelFromJson(String str) => TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());


/// Kullanıcı bilgileri olmadan ilk açılışta Get ettiğimiz token için kullanılmakta
class TokenModel {
  TokenModel({
    this.accessToken,
  });

  String? accessToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
  };
}
