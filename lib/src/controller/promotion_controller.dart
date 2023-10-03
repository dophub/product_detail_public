import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_detail/src/app/extension/order_model_extension.dart';
import 'package:sip_models/enum.dart';
import 'package:sip_models/request.dart';
import 'package:sip_models/response.dart';

/// Kullanım şekli:
/// .
/// .
/// View kısmında yazdığımızı view yi veriyoruz:
/// ...child: ProductDetailView(
///     controller: controller.promotionViewController,
/// ),.....
/// .
/// .
/// kontrolumuzu init yapıyoruz:
/// final PromotionViewController promotionViewController =  PromotionViewController(orderItem,promotionMenuModel,priceType);
/// .
/// .
/// Tutar değişkenini dinlemek istediğmizde:
/// promotionViewController.addListener(() {
///      amount = promotionViewController.value;
/// });
/// .
/// .
/// Ürün Adedini güncellemek istersek:
/// promotionViewController.count = _count;
/// .
/// .
/// Sepet modelini seçilen özeliklere göre getirmek istersek:
/// var item = promotionViewController.getBasketModel(TimeoutAction.Add);
/// .
/// .
/// Dispose işlemi
///  @override
///  void onClose() {
///    promotionViewController.dispose();
///    super.onClose();
///  }
///
///
class PromotionViewController extends ValueNotifier<double> {
  late final PromotionController _controller;

  /// [orderItem] Sipariş te olan ürün güncellemek istersek sipariş ürünü buraya veriyoruz
  /// [promotionMenuModel] apiden gelen ürün detayı
  PromotionViewController(OrderItem? orderItem, PromotionMenuDetailModel promotionMenuModel, PriceType priceType)
      : super(0) {
    _controller = Get.put(PromotionController(orderItem, promotionMenuModel, onChangeAmount, priceType));
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
  @override
  void dispose() {
    Get.delete<PromotionController>(force: true);
    super.dispose();
  }

  /// [ProductController] tarafından tetiklenip [ValueNotifier] in value sını güncellemekte
  void onChangeAmount(double amount) {
    value = amount;
  }

  /// Sepete Modelini oluşturmak için kullanımakta
  /// Sepete buttonuna tıklandığında çağırılıp sepete eklemek için post edilimekte
  ItemOrder? getBasketModel(TimeoutAction timeoutAction) => _controller._getBasketModel(timeoutAction);
}

class PromotionController extends GetxController {
  /// Promosyonlu Ürün Detay modelidir
  late Rx<PromotionMenuDetailModel> _promotionMenuModel;

  /// Sipariş te olan ürün detayidir
  late OrderItem? orderItem;

  /// Toplam tutarıdır
  late Rx<double> _amount;

  /// Note TextFiel din kontroludur
  late Rx<TextEditingController> _cNote;

  /// Ürün adedidir
  late Rx<int> _count;

  /// [ProductViewController] te extends edilen [ValueNotifier] value kısmını güncellemek için kullanılmakta
  Function(double) onChangeAmount;

  /// Fiyat Türü
  late PriceType priceType;

  final RxBool _validate = false.obs;

  /// Frame yüklendiğinde [initAfterProductDetailLoaded] i çağırmaktayiz
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    promotionMenuModel.initAfterProductDetailLoaded(orderItem: orderItem);
    amountUpdate();

    /// Getx pakat ile [_amount] i dinleyip [onChangeAmount] metodunu tetiklemekteyiz
    ever<double>(_amount, (value) {
      onChangeAmount(value);
    });
  }

  PromotionController(this.orderItem, PromotionMenuDetailModel _model, this.onChangeAmount, this.priceType) {
    _promotionMenuModel = _model.obs;

    /// [orderItem] olduğunda sepette olan ürünün notunu setlemekte
    /// yoksa boş olaçaktır
    _cNote = TextEditingController(text: orderItem == null ? '' : orderItem!.itemNote!).obs;
    _amount = 0.0.obs;

    /// [orderItem] olduğunda sepette olan ürünün adedini setlemekte
    /// yoksa 1 olaçaktır
    _count = orderItem == null ? 1.obs : orderItem!.count!.obs;
  }

  bool get validate => _validate.value;

  set validate(bool value) {
    _validate.value = value;
    update(['promotionDetailModelUpdate']);
  }

  int get count => _count.value;

  set count(int value) {
    _count.value = value;
  }

  double get amount => _amount.value;

  set amount(double value) {
    _amount.value = value;
  }

  PromotionMenuDetailModel get promotionMenuModel => _promotionMenuModel.value;

  set promotionMenuModel(PromotionMenuDetailModel value) {
    _promotionMenuModel.value = value;
    update(['promotionDetailModelUpdate']);
  }

  TextEditingController get cNote => _cNote.value;

  set cNote(TextEditingController value) {
    _cNote.value = value;
  }

  /// Açılan Bottom Sheet te Promosyon ürünler den ürün seçildğinde çalışan metod.
  /// [sectionIndex] section Id si.
  /// [selectedIndex] Seçilen ürünün index i
  void sectionBottomSheetOnChange(int sectionIndex, int selectedIndex) {
    PromotionMenuDetailModel value = promotionMenuModel;

    /// Tümünü sıfırla
    for (int i = 0; i < value.sections![sectionIndex].products!.length; i++) {
      value.sections![sectionIndex].products![i].isSelected = false;
    }

    /// Seçileni true yap
    value.sections![sectionIndex].products![selectedIndex].isSelected = true;

    /// Seçilen Sectioni de true yap
    value.sections![sectionIndex].isSelected = true;
    promotionMenuModel = value;
    amountUpdate();
  }

  /// Tekli opsiyon Seçimlerde çalışan metod
  void singleOptionSelection(int sectionIndex, int optionGroupsIndex, int selectedIndex) {
    PromotionMenuDetailModel value = promotionMenuModel;
    int productIndex = getIndexForSelectedProduct(sectionIndex)!;
    for (int i = 0;
        i < value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].options!.length;
        i++) {
      value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].options![i].isSelected =
          false;
    }
    value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].options![selectedIndex]
        .isSelected = true;
    value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].isSelected = true;
    promotionMenuModel = value;
    amountUpdate();
  }

  /// Tekli özelik Seçimlerde çalışan metod
  void singleFeatureSelection(int sectionIndex, int featureIndex, int selectedIndex) {
    PromotionMenuDetailModel value = promotionMenuModel;
    int productIndex = getIndexForSelectedProduct(sectionIndex)!;
    for (int i = 0;
        i < value.sections![sectionIndex].products![productIndex].features![featureIndex].items!.length;
        i++) {
      value.sections![sectionIndex].products![productIndex].features![featureIndex].items![i].isSelected = false;
    }
    value.sections![sectionIndex].products![productIndex].features![featureIndex].items![selectedIndex].isSelected =
        true;
    value.sections![sectionIndex].products![productIndex].features![featureIndex].isSelected = true;
    promotionMenuModel = value;
    amountUpdate();
  }

  /// Özelik Cıkarma section lerde çalışan metod.
  /// Birden fazla seçimlerde
  void multiDecreaseFeatureSelection(int sectionIndex, bool status, int featureIndex, int selectedIndex) {
    debugPrint(status.toString());
    PromotionMenuDetailModel value = promotionMenuModel;
    int productIndex = getIndexForSelectedProduct(sectionIndex)!;
    value.sections![sectionIndex].products![productIndex].features![featureIndex].items![selectedIndex].isSelected =
        status;
    value.sections![sectionIndex].products![productIndex].features![featureIndex].isSelected = true;
    promotionMenuModel = value;
  }

  /// Opsiyon Cıkarma section lerde çalışan metod.
  /// Birden fazla seçimlerde
  void multiDecreaseOptionSelection(int sectionIndex, bool status, int optionGroupsIndex, int selectedIndex) {
    debugPrint(status.toString());
    PromotionMenuDetailModel value = promotionMenuModel;
    int productIndex = getIndexForSelectedProduct(sectionIndex)!;
    value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].options![selectedIndex]
        .isSelected = status;
    value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].isSelected = true;
    promotionMenuModel = value;
  }

  /// Özelik Ekleme section lerde çalışan metod.
  /// Birden fazla seçimlerde.
  void multiAddFeatureSelection(int sectionIndex, bool status, int featureIndex, int selectedIndex) {
    debugPrint(status.toString());
    PromotionMenuDetailModel value = promotionMenuModel;
    int productIndex = getIndexForSelectedProduct(sectionIndex)!;
    value.sections![sectionIndex].products![productIndex].features![featureIndex].items![selectedIndex].isSelected =
        status;
    if (status) {
      value.sections![sectionIndex].products![productIndex].features![featureIndex].isSelected = true;
    } else {
      int itemsLength = value.sections![sectionIndex].products![productIndex].features![featureIndex].items!.length;
      for (int i = 0; i < itemsLength; i++) {
        if (value.sections![sectionIndex].products![productIndex].features![featureIndex].items![i].isSelected) {
          value.sections![sectionIndex].products![productIndex].features![featureIndex].isSelected = true;
          break;
        } else if (i == itemsLength - 1) {
          value.sections![sectionIndex].products![productIndex].features![featureIndex].isSelected = false;
        }
      }
    }
    promotionMenuModel = value;
    amountUpdate();
  }

  /// Opsiyon Ekleme section lerde çalışan metod.
  /// Birden fazla seçimlerde.
  void multiAddOptionSelection(int sectionIndex, bool status, int optionGroupsIndex, int selectedIndex) {
    debugPrint(status.toString());
    PromotionMenuDetailModel value = promotionMenuModel;
    int productIndex = getIndexForSelectedProduct(sectionIndex)!;
    value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].options![selectedIndex]
        .isSelected = status;
    if (status) {
      value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].isSelected = true;
    } else {
      int itemsLength =
          value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].options!.length;
      for (int i = 0; i < itemsLength; i++) {
        if (value
            .sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].options![i].isSelected) {
          value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].isSelected = true;
          break;
        } else if (i == itemsLength - 1) {
          value.sections![sectionIndex].products![productIndex].optionGroups![optionGroupsIndex].isSelected = false;
        }
      }
    }
    promotionMenuModel = value;
    amountUpdate();
  }

  /// Miktar buttonuna tıklandığı zaman çalışan metod
  void countUpdate(int _count) {
    amount = (amount / count) * _count;
    count = _count;
  }

  /// Secilen SECTION lere göre toplam tutarı güncellemekte
  void amountUpdate() {
    amount = promotionMenuModel.getTotalAmount(priceType: priceType, quantity: count);
  }

  /// Sepete Buttonuna tıklandığında tetiklenen Fon.
  ItemOrder? _getBasketModel(TimeoutAction timeoutAction) {
    try {
      final item = promotionMenuModel.getBasketModel(
        orderItemId: orderItem?.id,
        count: count,
        amount: amount,
        note: cNote.text,
        timeoutAction: timeoutAction,
      );
      return item;
    } on int catch (_) {
      validate = true;
      throw 'Zorunlu alanları seçin.';
    }
  }

  /// Promosyon ürünlerde Seçilen ürünün indexini getirmek için yzaıldı.
  int? getIndexForSelectedProduct(int sectionIndex) {
    int value = promotionMenuModel.sections![sectionIndex].products!.indexWhere((element) => element.isSelected);
    return value == -1 ? null : value;
  }

  /// Daha önceden seçilen özelik index i Getirmek için yazıldı.
  /// isSelected alanını kontrol etmekte.
  int? getIndexForSelectedFeatureItem(int? sectionIndex, int featureIndex) {
    int value;
    value = promotionMenuModel
        .sections![sectionIndex!].products![getIndexForSelectedProduct(sectionIndex)!].features![featureIndex].items!
        .indexWhere((element) => element.isSelected);
    return value == -1 ? null : value;
  }

  /// Daha önceden seçilen opsiyon index i Getirmek için yazıldı.
  /// isSelected alanını kontrol etmekte.
  int? getIndexForSelectedOption(int? sectionIndex, int optionGroupsIndex) {
    int value;
    value = promotionMenuModel.sections![sectionIndex!].products![getIndexForSelectedProduct(sectionIndex)!]
        .optionGroups![optionGroupsIndex].options!
        .indexWhere((element) => element.isSelected);
    return value == -1 ? null : value;
  }

  /// Promosiyonlı ürünler de seçilen ürünün opsiyonlarını getirmek için yazıldı
  List<OptionGroupModel>? getOptionsForSelectedProduct(int sectionIndex) {
    return promotionMenuModel.sections![sectionIndex].products!
        .firstWhere((element) => element.isSelected, orElse: () => ProductDetailModel())
        .optionGroups;
  }

  /// Promosiyonlı ürünler de seçilen ürünün özeliklerini getirmek için yazıldı
  List<FeatureModel>? getFeaturesForSelectedProduct(int sectionIndex) {
    return promotionMenuModel.sections![sectionIndex].products!
        .firstWhere((element) => element.isSelected, orElse: () => ProductDetailModel())
        .features;
  }

  /// Note Dialog u kapandığında çalışan Fonk.
  /// Girilen Notu Text Field kontrollune attıyor.
  void onCloseNotDialog(String note) {
    cNote.text = note;
    debugPrint(note);
  }
}
