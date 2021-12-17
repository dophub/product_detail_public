/// [ChooseTypeId] Ürün detay da ürün özelliklerin seçme türüdür
/// [SINGLE] Tekli seçme
/// [MULTIPLE] Çoklu seçme
enum ChooseTypeId { SINGLE, MULTIPLE }

/// [AddingTypeId] Ürün detay da ürün özelliklerin ekleme türüdür
/// [ADD] Ekleme
/// [DECREASE] çıkarma
/// [SELECT] Seçme
enum AddingTypeId { ADD, DECREASE, SELECT }

/// [ImageSizeId] Resimin hangi Liste türünde [ListMode] gözükeceğini belirten id
/// [mobile_list] bu resim türü [ListMode.Line] inde kulanılmakta
/// [mobile_list_col] bu resim türü [ListMode.Grid] inde kulanılmakta
/// [mobile_detail] Ürün Detay ekranında kullanılmakta
enum ImageSizeId { mobile_list, mobile_list_col, mobile_detail }
