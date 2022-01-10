/// [TimeoutAction] Dealer de Masa TimeOut durumu
/// [None] Sepete Ilk eklemede ekleyeceğmiz durum
/// [New] Yeni Service Başlatmak istiyorum
/// [Add] Masaya açık olan service devam etmek istiyorum
enum TimeoutAction { None, New, Add }

/// [PriceType] Fiyat Türleri
/// [TABLE] => Masadan Ödeme
/// [TAKEOUT] => Adrese Teslim
/// [GETIN] => Gel Al
enum PriceType { TABLE, TAKEOUT, GETIN }

/// [ProductType] Stok Türü
/// [PRODUCT] Normal Ürün
/// [PROMOTION_MENU] Promosyonlu ürün
enum ItemType { PRODUCT, PROMOTION_MENU }

/// [OptionType] Option türü
/// [OPTION] Item olmayan option
/// [FEATURE] Item olan option
enum OptionType { OPTION, FEATURE }

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

