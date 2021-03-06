import 'package:example/App/Constant/Enums/LoadingStatusEnum.dart';

/// [LoadingStatus] Enumun durumlarını kontrol etmek için yazıldı
extension LoadingStatusExtension on LoadingStatus {
  get isLoading => this == LoadingStatus.Loading;

  get isInit => this == LoadingStatus.Init;

  get isError => this == LoadingStatus.Error;

  get isLoaded => this == LoadingStatus.Loaded;
}

/// [BaseModelStatus] Enumun durumlarını kontrol etmek için yazıldı
extension BaseModelStatusExtension on BaseModelStatus {
  get isOk => this == BaseModelStatus.Ok;

  get isAction => this == BaseModelStatus.Action;

  get isError => this == BaseModelStatus.Error;

  get isUnprocessableEntity => this == BaseModelStatus.UnprocessableEntity;

  get isTimeOut => this == BaseModelStatus.TimeOut;
}
