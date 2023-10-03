import 'package:product_detail/src/app/extension/general_extension.dart';
import 'package:sip_models/enum.dart';
import 'package:sip_models/request.dart';
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
    item.product!.itemId = id;
    item.product!.productName = productName;
    final List<Options> selectedOptions = [];
    selectedOptions.addAll(optionGroups!.getSelected());
    selectedOptions.addAll(features!.getSelected());
    item.product!.options = selectedOptions;
    return item;
  }

  /// Secilen SECTION lere göre toplam tutarı güncellemekte
  double getTotalAmount({required PriceType priceType, required int quantity}) {
    double _amount = 0;
    _amount = price!.getPrice(priceType);

    /// OptionGroupss
    for (var optionGroups in optionGroups!) {
      if (optionGroups.isSelected) {
        for (var options in optionGroups.options!) {
          if (options.isSelected && !options.isFree!) _amount = _amount + options.addPrice!;
        }
      }
    }

    /// Feature
    for (var feature in features!) {
      if (feature.isSelected) {
        for (var item in feature.items!) {
          if (item.isSelected && !item.isFree!) _amount = _amount + item.addPrice!;
        }
      }
    }
    return _amount * quantity;
  }

  /// Frame yüklendikten sonra section lerde olan isDefault alanına göre isSelected alanlarımızı güncelliyoruz
  void initAfterProductDetailLoaded({required OrderItem? orderItem}) {
    if (orderItem != null) {
      ProductDetailModel product = orderItem.toProductDetailModel();
      // optionGroups loop
      for (int groupIndex = 0; groupIndex < optionGroups!.length; groupIndex++) {
        var i = product.optionGroups!.indexWhere((element) => element.id == optionGroups![groupIndex].id);
        if (i != -1) {
          // options loop
          for (int optionsIndex = 0; optionsIndex < optionGroups![groupIndex].options!.length; optionsIndex++) {
            if (product.optionGroups![i].options!
                .any((element) => element.id == optionGroups![groupIndex].options![optionsIndex].id)) {
              optionGroups![groupIndex].options![optionsIndex].isSelected = true;
              optionGroups![groupIndex].isSelected = true;
            }
          }
        }
      }
      // features loop
      for (int featuresIndex = 0; featuresIndex < features!.length; featuresIndex++) {
        var i = product.features!.indexWhere((element) => element.id == features![featuresIndex].id);
        if (i != -1) {
          // items loop
          for (int itemsIndex = 0; itemsIndex < features![featuresIndex].items!.length; itemsIndex++) {
            if (product.features![i].items!
                .any((element) => element.id == features![featuresIndex].items![itemsIndex].id)) {
              features![featuresIndex].items![itemsIndex].isSelected = true;
              features![featuresIndex].isSelected = true;
            }
          }
        }
      }
    } else {
      /// Normal ürün
      // optionGroups loop
      for (int groupIndex = 0; groupIndex < optionGroups!.length; groupIndex++) {
        // options loop
        for (int optionsIndex = 0; optionsIndex < optionGroups![groupIndex].options!.length; optionsIndex++) {
          if (optionGroups![groupIndex].options![optionsIndex].isDefault!) {
            optionGroups![groupIndex].options![optionsIndex].isSelected = true;
            optionGroups![groupIndex].isSelected = true;
          }
        }
      }
      // features loop
      for (int featuresIndex = 0; featuresIndex < features!.length; featuresIndex++) {
        // items loop
        for (int itemsIndex = 0; itemsIndex < features![featuresIndex].items!.length; itemsIndex++) {
          if (features![featuresIndex].items![itemsIndex].isDefault!) {
            features![featuresIndex].items![itemsIndex].isSelected = true;
            features![featuresIndex].isSelected = true;
          }
        }
      }
    }
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
    item.promotionMenu!.itemId = id;
    item.promotionMenu!.promotionName = promotionMenuName;
    item.promotionMenu!.sections = [];
    for (int sectionIndex = 0; sectionIndex < sections!.length; sectionIndex++) {
      /// TODO Yeni Eklendi
      /// Sectionlar zorunlu seçmelidir
      if (sections![sectionIndex].isSelected == false) {
        throw -1;
      }
      item.promotionMenu!.sections!.add(
        Section(
          sectionId: sections![sectionIndex].id,
          sectionTitle: sections![sectionIndex].sectionName,
          sectionItem: Product(),
        ),
      );
      int sectionLastIndex = item.promotionMenu!.sections!.length - 1;
      for (int productIndex = 0; productIndex < sections![sectionIndex].products!.length; productIndex++) {
        if (sections![sectionIndex].products![productIndex].isSelected == true) {
          item.promotionMenu!.sections![sectionLastIndex].sectionItem!.itemId =
              sections![sectionIndex].products![productIndex].id;
          item.promotionMenu!.sections![sectionLastIndex].sectionItem!.productName =
              sections![sectionIndex].products![productIndex].productName;
          final List<Options> selectedOptions = [];
          selectedOptions.addAll(sections![sectionIndex].products![productIndex].optionGroups!.getSelected());
          selectedOptions.addAll(sections![sectionIndex].products![productIndex].features!.getSelected());
          item.promotionMenu!.sections![sectionLastIndex].sectionItem!.options = selectedOptions;
        }
      }
    }
    return item;
  }

  double getTotalAmount({required PriceType priceType, required int quantity}) {
    double _amount = 0;
    _amount = price!.getPrice(priceType);

    /// section
    for (var section in sections!) {
      /// Products
      if (section.isSelected) {
        for (var product in section.products!) {
          if (product.isSelected) {
            /// selected section price
            _amount = _amount + (product.additionalPrice ?? 0.0);

            /// OptionGroups
            for (var optionGroups in product.optionGroups!) {
              if (optionGroups.isSelected) {
                for (var options in optionGroups.options!) {
                  if (options.isSelected && !options.isFree!) _amount = _amount + options.addPrice!;
                }
              }
            }

            /// Feature
            for (var feature in product.features!) {
              if (feature.isSelected) {
                for (var item in feature.items!) {
                  if (item.isSelected && !item.isFree!) _amount = _amount + item.addPrice!;
                }
              }
            }
          }
        }
      }
    }
    return _amount * quantity;
  }

  /// Frame yüklendikten sonra section lerde olan isDefault alanına göre isSelected alanlarımızı güncelliyoruz
  void initAfterProductDetailLoaded({required OrderItem? orderItem}) {
    // sections loop
    if (orderItem != null) {
      PromotionMenuDetailModel product = orderItem.toPromotionModel();
      for (int sectionsIndex = 0; sectionsIndex < sections!.length; sectionsIndex++) {
        final sections = this.sections![sectionsIndex];
        final orderSections =
            product.sections!.firstWhere((element) => element.id == sections.id, orElse: () => SectionModel());
        if (orderSections.id != null) {
          sections.isSelected = true;
          for (int productsIndex = 0; productsIndex < sections.products!.length; productsIndex++) {
            var products = sections.products![productsIndex];
            var orderProducts = orderSections.products!
                .firstWhere((element) => element.id == products.id, orElse: () => ProductDetailModel());
            if (orderProducts.id != null) {
              products.isSelected = true;
              // optionGroups loop
              for (int groupIndex = 0; groupIndex < products.optionGroups!.length; groupIndex++) {
                var optionGroups = products.optionGroups![groupIndex];
                var orderOptionGroups = orderProducts.optionGroups!
                    .firstWhere((element) => element.id == optionGroups.id, orElse: () => OptionGroupModel());
                // options loop
                if (orderOptionGroups.id != null) {
                  for (int optionsIndex = 0; optionsIndex < optionGroups.options!.length; optionsIndex++) {
                    var orderOption = orderOptionGroups.options!.firstWhere(
                        (element) => element.id == optionGroups.options![optionsIndex].id,
                        orElse: () => OptionModel());
                    if (orderOption.id != null) {
                      optionGroups.options![optionsIndex].isSelected = true;
                      optionGroups.isSelected = true;
                    }
                  }
                }
              }
              // features loop
              for (int featuresIndex = 0; featuresIndex < products.features!.length; featuresIndex++) {
                var features = products.features![featuresIndex];
                var orderFeatures = orderProducts.features!
                    .firstWhere((element) => element.id == features.id, orElse: () => FeatureModel());
                // items loop
                if (orderFeatures.id != null) {
                  for (int itemsIndex = 0; itemsIndex < features.items!.length; itemsIndex++) {
                    var orderFeatureItem = orderFeatures.items!.firstWhere(
                        (element) => element.id == features.items![itemsIndex].id,
                        orElse: () => ItemModel());
                    if (orderFeatureItem.id != null) {
                      features.items![itemsIndex].isSelected = true;
                      features.isSelected = true;
                    }
                  }
                }
              }
            }
          }
        }
      }
    } else {
      for (int sectionsIndex = 0; sectionsIndex < sections!.length; sectionsIndex++) {
        var sections = this.sections![sectionsIndex];
        for (int productsIndex = 0; productsIndex < sections.products!.length; productsIndex++) {
          var products = sections.products![productsIndex];
          // optionGroups loop
          for (int groupIndex = 0; groupIndex < products.optionGroups!.length; groupIndex++) {
            var optionGroups = products.optionGroups![groupIndex];
            // options loop
            for (int optionsIndex = 0; optionsIndex < optionGroups.options!.length; optionsIndex++) {
              if (optionGroups.options![optionsIndex].isDefault!) {
                optionGroups.options![optionsIndex].isSelected = true;
                optionGroups.isSelected = true;
              }
            }
          }
          // features loop
          for (int featuresIndex = 0; featuresIndex < products.features!.length; featuresIndex++) {
            var features = products.features![featuresIndex];
            // items loop
            for (int itemsIndex = 0; itemsIndex < features.items!.length; itemsIndex++) {
              if (features.items![itemsIndex].isDefault!) {
                features.items![itemsIndex].isSelected = true;
                features.isSelected = true;
              }
            }
          }
        }
      }
    }
  }
}

extension OptionGroupListExtension on List<OptionGroupModel> {
  /// Ürünün seçilen opsiyonlsarını getirmek için yazıldı.
  /// Ürünü sepette eklerken çalışmakta olup [getBasketModel] metodında çağrılmakta.
  List<Options> getSelected() {
    List<Options> options = [];

    /// optionGroups
    for (int groupIndex = 0; groupIndex < length; groupIndex++) {
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

extension FeatureListExtension on List<FeatureModel> {
  /// Ürünün seçilen opsiyonlsarını getirmek için yazıldı.
  /// Ürünü sepette eklerken çalışmakta olup [getBasketModel] metodında çağrılmakta.
  List<Options> getSelected() {
    List<Options> options = [];

    /// feature
    for (int groupIndex = 0; groupIndex < length; groupIndex++) {
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

extension ProductModelExtension on ProductModel {
  /// Opsiyonsuz Order modeli oluşturmak için yazıldı.
  /// Opsiyonu olmayan ProductCard e olan sepete ekle buttonuna tıklandığında modeli oluşturmak için kullanılmakta.
  ItemOrder? getBasketModelWithOutOption(PriceType priceType, TimeoutAction timeoutAction) {
    final amount = price!.getPrice(priceType);
    final item = ItemOrder(id: 0);

    /// Yeni ürün olduğuda 0 önceden eklenen ürünü güncelliyorsak order de dönen id yi veriyoruz
    item.id = 0;
    item.timeoutAction = timeoutAction.name;
    item.note = '';
    item.count = 1;
    item.itemAmount = amount;
    item.totalAmount = amount;
    item.note = '';
    item.product = Product();
    item.itemType = ItemType.PRODUCT.name;
    item.product!.itemId = id;
    item.product!.productName = productName;
    item.product!.options = null;
    return item;
  }
}

extension OptionGroupExtension on OptionGroupModel {
  /// Tekli opsiyon Seçimlerde çalışan metod
  void singleOptionSelection(int selectedIndex) {
    for (int i = 0; i < options!.length; i++) {
      options![i].isSelected = false;
    }
    options![selectedIndex].isSelected = true;
    isSelected = true;
  }

  /// Opsiyon Cıkarma section lerde çalışan metod.
  /// Birden fazla seçimlerde
  void multiDecreaseOptionSelection(bool status, int selectedIndex) {
    options![selectedIndex].isSelected = status;
    isSelected = true;
  }

  /// Opsiyon Ekleme section lerde çalışan metod.
  /// Birden fazla seçimlerde.
  void multiAddOptionSelection(bool status, int selectedIndex) {
    options![selectedIndex].isSelected = status;
    if (status) {
      isSelected = true;
    } else {
      int itemsLength = options!.length;
      for (int i = 0; i < itemsLength; i++) {
        if (options![i].isSelected) {
          isSelected = true;
          break;
        } else if (i == itemsLength - 1) {
          isSelected = false;
        }
      }
    }
  }
}

extension FeatureExtension on FeatureModel {
  /// Tekli özelik Seçimlerde çalışan metod
  void singleFeatureSelection(int selectedIndex) {
    for (int i = 0; i < items!.length; i++) {
      items![i].isSelected = false;
    }
    items![selectedIndex].isSelected = true;
    isSelected = true;
  }

  /// Özelik Cıkarma section lerde çalışan metod.
  /// Birden fazla seçimlerde
  void multiDecreaseFeatureSelection(bool status, int selectedIndex) {
    items![selectedIndex].isSelected = status;
    isSelected = true;
  }

  /// Özelik Ekleme section lerde çalışan metod.
  /// Birden fazla seçimlerde.
  void multiAddFeatureSelection(bool status, int selectedIndex) {
    items![selectedIndex].isSelected = status;
    if (status) {
      isSelected = true;
    } else {
      int itemsLength = items!.length;
      for (int i = 0; i < itemsLength; i++) {
        if (items![i].isSelected) {
          isSelected = true;
          break;
        } else if (i == itemsLength - 1) {
          isSelected = false;
        }
      }
    }
  }
}

extension SectionExtension on SectionModel {
  /// Promosyon ürünlerde Seçilen ürünün indexini getirmek için yzaıldı.
  int? getIndexForSelectedProduct() {
    final value = products!.indexWhere((element) => element.isSelected);
    return value == -1 ? null : value;
  }

  /// Daha önceden seçilen özelik index i Getirmek için yazıldı.
  /// isSelected alanını kontrol etmekte.
  int? getIndexForSelectedFeatureItem(int featureIndex) {
    final value = products![getIndexForSelectedProduct()!]
        .features![featureIndex]
        .items!
        .indexWhere((element) => element.isSelected);
    return value == -1 ? null : value;
  }

  /// Daha önceden seçilen opsiyon index i Getirmek için yazıldı.
  /// isSelected alanını kontrol etmekte.
  int? getIndexForSelectedOption(int optionGroupsIndex) {
    final value = products![getIndexForSelectedProduct()!]
        .optionGroups![optionGroupsIndex]
        .options!
        .indexWhere((element) => element.isSelected);
    return value == -1 ? null : value;
  }

  /// Promosiyonlı ürünler de seçilen ürünün opsiyonlarını getirmek için yazıldı
  List<OptionGroupModel>? getOptionsForSelectedProduct(int sectionIndex) {
    return products!.firstWhere((element) => element.isSelected, orElse: () => ProductDetailModel()).optionGroups;
  }

  /// Promosiyonlı ürünler de seçilen ürünün özeliklerini getirmek için yazıldı
  List<FeatureModel>? getFeaturesForSelectedProduct(int sectionIndex) {
    return products!.firstWhere((element) => element.isSelected, orElse: () => ProductDetailModel()).features;
  }
}
