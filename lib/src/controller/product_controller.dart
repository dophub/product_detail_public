import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:product_detail/src/app/extension/general_extension.dart';
import 'package:sip_models/enum.dart';
import 'package:sip_models/request.dart';
import 'package:sip_models/response.dart';


///
/// Kullanım şekli:
///
///
/// View kısmında yazdığımızı view yi veriyoruz:
///    child: ProductDetailView(
///     controller: controller.productViewController,
/// ),
///
///
/// kontrolumuzu init yapıyoruz:
/// final ProductViewController productViewController =  ProductViewController(orderItem,productDetailModel,priceType);
///
///
/// Tutar değişkenini dinlemek istediğmizde:
/// productViewController.addListener(() {
///      amount = productViewController.value;
/// });
///
///
/// Ürün Adedini güncellemek istersek:
/// productViewController.count = _count;
///
///
/// Sepet modelini seçilen özeliklere göre getirmek istersek:
/// var item = productViewController.getBasketModel(TimeoutAction.Add);
///
///
/// Dispose işlemi
/// @override
/// void onClose() {
///   promotionViewController.dispose();
///   super.onClose();
/// }
///
///
class ProductViewController extends ValueNotifier<double> {
  late final ProductController _controller;

  /// [orderItem] Sipariş te olan ürün güncellemek istersek sipariş ürünü buraya veriyoruz
  /// [productDetailModel] apiden gelen ürün detayı
  ProductViewController(OrderItem? orderItem,ProductDetailModel productDetailModel,PriceType priceType) : super(0.0){
    _controller = Get.put(ProductController(orderItem,productDetailModel,onChangeAmount,priceType));
  }

  /// Ürün adedini güncellemek için kullanılmakta
  set count(int _count) => _controller.countUpdate(_count);

  /// Kullanıcının seçtiği özeliklere ve adede göre güncell toplam tutardır
  double get amount => _controller.amount;

  @override
  set value(double newValue) => super.value = newValue;

  /// Oluşturulan tüm Get state lerini silmekte
  /// Dispose metodunda çağırılmalıdır
  /// çağırılmama durumda state hafızada tutulup bi sonraki girişte durmunu güncellemeyecektir
  void dispose(){
    Get.delete<ProductController>(force: true);
    super.dispose();
  }

  /// [ProductController] tarafından tetiklenip [ValueNotifier] in value sını güncellemekte
  void onChangeAmount(double amount){
    value = amount;
  }

  /// Sepete Modelini oluşturmak için kullanımakta
  /// Sepete buttonuna tıklandığında çağırılıp sepete eklemek için post edilimekte
  ItemOrder? getBasketModel(TimeoutAction timeoutAction) => _controller.getBasketModel(timeoutAction);
}

class ProductController extends GetxController {

  /// Ürün Detay modelidir
  late Rx<ProductDetailModel> _productDetailModel;

  /// Toplam tutarıdır
  late Rx<double> _amount;

  /// Ürün adedidir
  late Rx<int> _count;

  /// Note TextFiel din kontroludur
  late Rx<TextEditingController> _cNote;

  /// Sipariş te olan ürün detayidir
  late OrderItem? orderItem;

  /// [ProductViewController] te extends edilen [ValueNotifier] value kısmını güncellemek için kullanılmakta
  Function(double) onChangeAmount;

  /// Fiyat türü
  late PriceType priceType;

  /// Frame yüklendiğinde [_initAfterProductDetailLoaded] i çağırmaktayiz
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    _initAfterProductDetailLoaded();
    /// Getx pakat ile [_amount] i dinleyip [onChangeAmount] metodunu tetiklemekteyiz
    ever<double>(_amount, (value) {
      onChangeAmount(value);
    });
  }

  ProductController(this.orderItem,ProductDetailModel productDetailModel,this.onChangeAmount,this.priceType) {
    _productDetailModel = productDetailModel.obs;

    /// [orderItem] olduğunda sepette olan ürünün notunu setlemekte
    /// yoksa boş olaçaktır
    _cNote = TextEditingController(text:orderItem == null ? '' : orderItem!.itemNote! ).obs;
    _amount = 0.0.obs;

    /// [orderItem] olduğunda sepette olan ürünün adedini setlemekte
    /// yoksa 1 olaçaktır
    _count = orderItem == null ? 1.obs : orderItem!.count!.obs;
  }

  int get count => _count.value;

  set count(int value) {
    _count.value = value;
  }

  double get amount => _amount.value;

  set amount(double value) {
    _amount.value = value;
  }

  ProductDetailModel get productDetailModel => _productDetailModel.value;

  set productDetailModel(ProductDetailModel value) {
    _productDetailModel.value = value;
    update(['productDetailModelUpdate']);
  }

  TextEditingController get cNote => _cNote.value;

  set cNote(TextEditingController value) {
    _cNote.value = value;
  }



  /// Tekli opsiyon Seçimlerde çalışan metod
  void singleOptionSelection(int optionGroupsIndex, int selectedIndex) {
      ProductDetailModel value = productDetailModel;
      for (int i = 0; i < value.optionGroups![optionGroupsIndex].options!.length; i++)
        value.optionGroups![optionGroupsIndex].options![i].isSelected = false;
      value.optionGroups![optionGroupsIndex].options![selectedIndex].isSelected = true;
      value.optionGroups![optionGroupsIndex].isSelected = true;
      productDetailModel = value;
    amountUpdate();
  }

  /// Tekli özelik Seçimlerde çalışan metod
  void singleFeatureSelection(int featureIndex, int selectedIndex) {
      ProductDetailModel value = productDetailModel;
      for (int i = 0; i < value.features![featureIndex].items!.length; i++)
        value.features![featureIndex].items![i].isSelected = false;
      value.features![featureIndex].items![selectedIndex].isSelected = true;
      value.features![featureIndex].isSelected = true;
      productDetailModel = value;
    amountUpdate();
  }

  /// Özelik Cıkarma section lerde çalışan metod.
  /// Birden fazla seçimlerde
  void multiDecreaseFeatureSelection(bool status, int featureIndex, int selectedIndex) {
      ProductDetailModel value = productDetailModel;
      value.features![featureIndex].items![selectedIndex].isSelected = status;
      value.features![featureIndex].isSelected = true;
      productDetailModel = value;
  }

  /// Opsiyon Cıkarma section lerde çalışan metod.
  /// Birden fazla seçimlerde
  void multiDecreaseOptionSelection(bool status, int optionGroupsIndex, int selectedIndex) {
      ProductDetailModel value = productDetailModel;
      value.optionGroups![optionGroupsIndex].options![selectedIndex].isSelected = status;
      value.optionGroups![optionGroupsIndex].isSelected = true;
      productDetailModel = value;
  }

  /// Özelik Ekleme section lerde çalışan metod.
  /// Birden fazla seçimlerde.
  void multiAddFeatureSelection(bool status, int featureIndex, int selectedIndex) {
    print(status);
      ProductDetailModel value = productDetailModel;
      value.features![featureIndex].items![selectedIndex].isSelected = status;
      if (status)
        value.features![featureIndex].isSelected = true;
      else {
        int itemsLength = value.features![featureIndex].items!.length;
        for (int i = 0; i < itemsLength; i++) {
          if (value.features![featureIndex].items![i].isSelected) {
            value.features![featureIndex].isSelected = true;
            break;
          } else if (i == itemsLength - 1) {
            value.features![featureIndex].isSelected = false;
          }
        }
      }
      productDetailModel = value;
    amountUpdate();
  }

  /// Opsiyon Ekleme section lerde çalışan metod.
  /// Birden fazla seçimlerde.
  void multiAddOptionSelection(bool status, int optionGroupsIndex, int selectedIndex) {
    print(status);
      ProductDetailModel value = productDetailModel;
      value.optionGroups![optionGroupsIndex].options![selectedIndex].isSelected = status;
      if (status)
        value.optionGroups![optionGroupsIndex].isSelected = true;
      else {
        int itemsLength = value.optionGroups![optionGroupsIndex].options!.length;
        for (int i = 0; i < itemsLength; i++) {
          if (value.optionGroups![optionGroupsIndex].options![i].isSelected) {
            value.optionGroups![optionGroupsIndex].isSelected = true;
            break;
          } else if (i == itemsLength - 1) {
            value.optionGroups![optionGroupsIndex].isSelected = false;
          }
        }
      }
      productDetailModel = value;
    amountUpdate();
  }

  /// Miktar buttonuna tıklandığı zaman çalışan metod
  void countUpdate(int _count) {
    amount = (amount / count) * _count;
    count = _count;
  }

  /// Secilen SECTION lere göre toplam tutarı güncellemekte
  void amountUpdate() {
    double _amount = 0;
      ProductDetailModel value = productDetailModel;
      _amount = value.price!.getPrice(priceType);

      /// OptionGroupss
      value.optionGroups!.forEach((OptionGroupModel optionGroups) {
        if (optionGroups.isSelected)
          optionGroups.options!.forEach((OptionModel options) {
            if (options.isSelected && !options.isFree!)
              _amount = _amount + options.addPrice!;
          });
      });

      /// Feature
      value.features!.forEach((FeatureModel feature) {
        if (feature.isSelected)
          feature.items!.forEach((ItemModel item) {
            if (item.isSelected && !item.isFree!)
              _amount = _amount + item.addPrice!;
          });
      });
    amount = _amount * count;
  }

  /// Sepete Buttonuna tıklandığında tetiklenen Fon.
  ItemOrder? getBasketModel(TimeoutAction timeoutAction) {
    var item = ItemOrder(id: 0);
    /// Yeni ürün olduğuda 0 önceden eklenen ürünü güncelliyorsak order de dönen id yi veriyoruz
    item.id = orderItem == null ? 0 : orderItem!.id!;
    item.timeoutAction = describeEnum(timeoutAction);
    item.note = '';
    item.count = count;
    item.itemAmount = amount;
    item.totalAmount = amount / count;
    item.note = cNote.text;
    item.product = Product();
    item.itemType = describeEnum(ItemType.PRODUCT);
    item.product!.itemId = productDetailModel.id;
    item.product!.productName = productDetailModel.productName;
    item.product!.options = _getSelectedOption(productDetailModel.optionGroups!, productDetailModel.features!);
    return item;
  }

  /// Ürünün seçilen opsiyonlsarını getirmek için yazıldı.
  /// Ürünü sepette eklerken çalışmakta olup [getBasketModel] metodında çağrılmakta.
  List<Options> _getSelectedOption(List<OptionGroupModel> optionGroups, List<FeatureModel> features) {
    List<Options> options = [];
    /// optionGroups
    for (int groupIndex = 0; groupIndex < optionGroups.length; groupIndex++) {

      if (optionGroups[groupIndex].isSelected) {
        options.add(
          Options(
            optionType: describeEnum(OptionType.OPTION),
            id: optionGroups[groupIndex].id,
            title: optionGroups[groupIndex].optionGroupName,
            addingType: optionGroups[groupIndex].addingTypeId,
            totalPrice: 0.0,
            items: [],
          ),
        );
        int lastOptionIndex = options.length - 1;

        /// Options
        for (int optionIndex = 0; optionIndex < optionGroups[groupIndex].options!.length; optionIndex++) {
          if (optionGroups[groupIndex].options![optionIndex].isSelected) {
            options[lastOptionIndex].items!.add(
              Items(
                id: optionGroups[groupIndex].options![optionIndex].id,
                title: optionGroups[groupIndex].options![optionIndex].optionName,
                price: optionGroups[groupIndex].options![optionIndex].addPrice,
                productId: 0,
              ),
            );
          }
        }
      }
      /// TODO Yeni Eklendi
      else if (optionGroups[groupIndex].isRequire == true) {
        throw 'Zorunlu alanları seçin.';
      }
    }

    /// feature
    for (int groupIndex = 0; groupIndex < features.length; groupIndex++) {
      if (features[groupIndex].isSelected) {
        options.add(
          Options(
            optionType: describeEnum(OptionType.FEATURE),
            id: features[groupIndex].id,
            title: features[groupIndex].featureName,
            addingType: features[groupIndex].addingTypeId,
            totalPrice: 0.0,
            items: [],
          ),
        );
        int lastFeatureIndex = options.length - 1;
        /// Options
        for (int optionIndex = 0; optionIndex < features[groupIndex].items!.length; optionIndex++) {
          if (features[groupIndex].items![optionIndex].isSelected) {
            options[lastFeatureIndex].items!.add(
              Items(
                id: features[groupIndex].items![optionIndex].id,
                title: features[groupIndex].items![optionIndex].productName,
                price: features[groupIndex].items![optionIndex].addPrice,
                productId: 1,
              ),
            );
          }
        }
      }
      /// TODO Yeni Eklendi
      else if (features[groupIndex].isRequire == true) {
        throw 'Zorunlu alanları seçin.';
      }
    }
    return options;
  }


  /// Daha önceden seçilen özelik index i Getirmek için yazıldı.
  /// isSelected alanını kontrol etmekte.
  int? getIndexForSelectedFeatureItem(int featureIndex) {
    int value;
      value = productDetailModel.features![featureIndex].items!.indexWhere((element) => element.isSelected);
      return value == -1 ? null : value;
  }

  /// Daha önceden seçilen opsiyon index i Getirmek için yazıldı.
  /// isSelected alanını kontrol etmekte.
  int? getIndexForSelectedOption(int optionGroupsIndex) {
    int value;
      value = productDetailModel.optionGroups![optionGroupsIndex].options!.indexWhere((element) => element.isSelected);
      return value == -1 ? null : value;
  }


  /// Frame yüklendikten sonra section lerde olan isDefault alanına göre isSelected alanlarımızı güncelliyoruz
  void _initAfterProductDetailLoaded() {
    if(orderItem != null){
      ProductDetailModel product = orderItem!.toProductDetailModel();
      // optionGroups loop
      for (int groupIndex = 0; groupIndex < productDetailModel.optionGroups!.length; groupIndex++) {
        var i = product.optionGroups!.indexWhere((element) => element.id == productDetailModel.optionGroups![groupIndex].id);
        if (i != -1) {
          // options loop
          for (int optionsIndex = 0; optionsIndex < productDetailModel.optionGroups![groupIndex].options!.length; optionsIndex++) {
            if (product.optionGroups![i].options!.any((element) => element.id == productDetailModel.optionGroups![groupIndex].options![optionsIndex].id)) {
              productDetailModel.optionGroups![groupIndex].options![optionsIndex].isSelected = true;
              productDetailModel.optionGroups![groupIndex].isSelected = true;
            }
          }
        }
      }
      // features loop
      for (int featuresIndex = 0; featuresIndex < productDetailModel.features!.length; featuresIndex++) {
        var i = product.features!.indexWhere((element) => element.id == productDetailModel.features![featuresIndex].id);
        if (i != -1) {
        // items loop
        for (int itemsIndex = 0; itemsIndex < productDetailModel.features![featuresIndex].items!.length; itemsIndex++) {
          if (product.features![i].items!.any((element) => element.id == productDetailModel.features![featuresIndex].items![itemsIndex].id)) {
            productDetailModel.features![featuresIndex].items![itemsIndex].isSelected = true;
            productDetailModel.features![featuresIndex].isSelected = true;
          }
        }
        }
      }
    }
    else{
      /// Normal ürün
      // optionGroups loop
      for (int groupIndex = 0; groupIndex < productDetailModel.optionGroups!.length; groupIndex++) {
        // options loop
        for (int optionsIndex = 0; optionsIndex < productDetailModel.optionGroups![groupIndex].options!.length; optionsIndex++) {
          if (productDetailModel.optionGroups![groupIndex].options![optionsIndex].isDefault!) {
            productDetailModel.optionGroups![groupIndex].options![optionsIndex].isSelected = true;
            productDetailModel.optionGroups![groupIndex].isSelected = true;
          }
        }
      }
      // features loop
      for (int featuresIndex = 0; featuresIndex < productDetailModel.features!.length; featuresIndex++) {
        // items loop
        for (int itemsIndex = 0; itemsIndex < productDetailModel.features![featuresIndex].items!.length; itemsIndex++) {
          if (productDetailModel.features![featuresIndex].items![itemsIndex].isDefault!) {
            productDetailModel.features![featuresIndex].items![itemsIndex].isSelected = true;
            productDetailModel.features![featuresIndex].isSelected = true;
          }
        }
      }
    }
    amountUpdate();
  }

  /// Note Dialog u kapandığında çalışan Fonk.
  /// Girilen Notu Text Field kontrollune attıyor.
  void onCloseNotDialog(String note) {
    cNote.text = note;
    print(note);
  }
}
