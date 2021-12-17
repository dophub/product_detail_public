

/// [OUT_TEMP] Cihazda
/// [OUT_WAIT] Onay Bekliyor
/// [OUT_ACCEPT] Onaylandı
/// [OUT_KITCHEN] Hazırlanıyor
/// [OUT_ON_WAY] Yolda
/// [OUT_DELIVERYOK] Teslim Edildi
/// [OUT_COMPLETE] Tamamlandı
/// [OUT_CANCEL] İptal
enum TakeOutOrderStatus {
  OUT_TEMP,
  OUT_WAIT,
  OUT_ACCEPT,
  OUT_KITCHEN,
  OUT_ON_WAY,
  OUT_DELIVERYOK,
  OUT_COMPLETE,
  OUT_CANCEL
}

/// [GET_TEMP] Cihazda
/// [GET_WAIT] Bekliyor
/// [GET_ACCEPT] Onaylandı
/// [GET_KITCHEN] Hazırlanıyor
/// [GET_READY] Kasada Hazır
/// [GET_COMPLETE] Tamamlandı
/// [GET_CANCEL] İptal
enum GetInOrderStatus {
  GET_TEMP,
  GET_WAIT,
  GET_ACCEPT,
  GET_KITCHEN,
  GET_READY,
  GET_COMPLETE,
  GET_CANCEL
}

/// [IN_TEMP] Cihazda
/// [IN_WAIT] Bekliyor
/// [IN_ACCEPT] Onaylandı
/// [IN_KITCHEN] Hazırlanıyor
/// [IN_TABLE] Masada
/// [IN_COMPLETE] Tamamlandı
/// [IN_CANCEL] İptal
enum TableOrderStatus {
  IN_TEMP,
  IN_WAIT,
  IN_ACCEPT,
  IN_KITCHEN,
  IN_TABLE,
  IN_COMPLETE,
  IN_CANCEL
}
