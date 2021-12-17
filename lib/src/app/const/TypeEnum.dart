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
