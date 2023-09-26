import 'package:sip_models/enum.dart';
import 'package:sip_models/response.dart';

extension OrderModelExtension on ProductDetailModel {
  /// Sepete Buttonuna tıklandığında tetiklenen Fon.
  ItemOrder? getBasketModel({
    orderItemId,
    required int count,
    required double amount,
    required String note,
    required TimeoutAction timeoutAction,
  }) {
    var item = ItemOrder(id: 0);

    /// Yeni ürün olduğuda 0 önceden eklenen ürünü güncelliyorsak order de dönen id yi veriyoruz
    item.id = orderItemId ?? 0;
    item.timeoutAction = timeoutAction.name;
    item.note = '';
    item.count = count;
    item.itemAmount = amount;
    item.totalAmount = amount / count;
    item.note = note;
    item.product = Product();
    item.itemType = ItemType.PRODUCT.name;
    item.product!.itemId = this.id;
    item.product!.productName = this.productName;
    final List<Options> selectedOptions = [];
    selectedOptions.addAll(this.optionGroups!.getSelected());
    selectedOptions.addAll(this.features!.getSelected());
    item.product!.options = selectedOptions;
    return item;
  }
}

extension PromotionModelExtension on PromotionMenuDetailModel {
  /// Sepete Buttonuna tıklandığında tetiklenen Fon.
  ItemOrder? getBasketModel({
    orderItemId,
    required int count,
    required double amount,
    required String note,
    required TimeoutAction timeoutAction,
  }) {
    /// Yeni ürün olduğuda 0 önceden eklenen ürünü güncelliyorsak order de dönen id yi veriyoruz
    final item = ItemOrder(id: 0);
    item.id = orderItemId ?? 0;
    item.timeoutAction = timeoutAction.name;
    item.note = '';
    item.count = count;
    item.itemAmount = amount;
    item.totalAmount = amount / count;
    item.note = note;
    item.promotionMenu = PromotionMenu();
    item.itemType = ItemType.PROMOTION_MENU.name;
    item.promotionMenu!.itemId = this.id;
    item.promotionMenu!.promotionName = this.promotionMenuName;
    item.promotionMenu!.sections = [];
    for (int sectionIndex = 0; sectionIndex < this.sections!.length; sectionIndex++) {
      /// TODO Yeni Eklendi
      /// Sectionlar zorunlu seçmelidir
      if (this.sections![sectionIndex].isSelected == false) {
        throw -1;
      }
      item.promotionMenu!.sections!.add(
        Section(
          sectionId: this.sections![sectionIndex].id,
          sectionTitle: this.sections![sectionIndex].sectionName,
          sectionItem: Product(),
        ),
      );
      int sectionLastIndex = item.promotionMenu!.sections!.length - 1;
      for (int productIndex = 0; productIndex < this.sections![sectionIndex].products!.length; productIndex++) {
        if (this.sections![sectionIndex].products![productIndex].isSelected == true) {
          item.promotionMenu!.sections![sectionLastIndex].sectionItem!.itemId =
              this.sections![sectionIndex].products![productIndex].id;
          item.promotionMenu!.sections![sectionLastIndex].sectionItem!.productName =
              this.sections![sectionIndex].products![productIndex].productName;
          final List<Options> selectedOptions = [];
          selectedOptions.addAll(this.sections![sectionIndex].products![productIndex].optionGroups!.getSelected());
          selectedOptions.addAll(this.sections![sectionIndex].products![productIndex].features!.getSelected());
          item.promotionMenu!.sections![sectionLastIndex].sectionItem!.options = selectedOptions;
        }
      }
    }
    return item;
  }
}

extension OptionExtension on List<OptionGroupModel> {
  /// Ürünün seçilen opsiyonlsarını getirmek için yazıldı.
  /// Ürünü sepette eklerken çalışmakta olup [getBasketModel] metodında çağrılmakta.
  List<Options> getSelected() {
    List<Options> options = [];

    /// optionGroups
    for (int groupIndex = 0; groupIndex < this.length; groupIndex++) {
      if (this[groupIndex].isSelected) {
        options.add(
          Options(
            optionType: OptionType.OPTION.name,
            id: this[groupIndex].id,
            title: this[groupIndex].optionGroupName,
            addingType: this[groupIndex].addingTypeId,
            totalPrice: 0.0,
            items: [],
          ),
        );
        int lastOptionIndex = options.length - 1;

        /// Options
        for (int optionIndex = 0; optionIndex < this[groupIndex].options!.length; optionIndex++) {
          if (this[groupIndex].options![optionIndex].isSelected) {
            options[lastOptionIndex].items!.add(
                  Items(
                    id: this[groupIndex].options![optionIndex].id,
                    title: this[groupIndex].options![optionIndex].optionName,
                    price: this[groupIndex].options![optionIndex].addPrice,
                    productId: 0,
                  ),
                );
          }
        }
      }

      /// TODO Yeni Eklendi
      else if (this[groupIndex].isRequire == true) {
        throw -1;
      }
    }
    return options;
  }
}

extension FeatureExtension on List<FeatureModel> {
  /// Ürünün seçilen opsiyonlsarını getirmek için yazıldı.
  /// Ürünü sepette eklerken çalışmakta olup [getBasketModel] metodında çağrılmakta.
  List<Options> getSelected() {
    List<Options> options = [];

    /// feature
    for (int groupIndex = 0; groupIndex < this.length; groupIndex++) {
      if (this[groupIndex].isSelected) {
        options.add(
          Options(
            optionType: OptionType.FEATURE.name,
            id: this[groupIndex].id,
            title: this[groupIndex].featureName,
            addingType: this[groupIndex].addingTypeId,
            totalPrice: 0.0,
            items: [],
          ),
        );
        int lastFeatureIndex = options.length - 1;

        /// Options
        for (int optionIndex = 0; optionIndex < this[groupIndex].items!.length; optionIndex++) {
          if (this[groupIndex].items![optionIndex].isSelected) {
            options[lastFeatureIndex].items!.add(
                  Items(
                    id: this[groupIndex].items![optionIndex].id,
                    title: this[groupIndex].items![optionIndex].productName,
                    price: this[groupIndex].items![optionIndex].addPrice,
                    productId: 1,
                  ),
                );
          }
        }
      }

      /// TODO Yeni Eklendi
      else if (this[groupIndex].isRequire == true) {
        throw -1;
      }
    }
    return options;
  }
}
