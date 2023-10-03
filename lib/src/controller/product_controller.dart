import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_detail/src/app/extension/order_model_extension.dart';
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
  ProductViewController(OrderItem? orderItem, ProductDetailModel productDetailModel, PriceType priceType) : super(0.0) {
    _controller = Get.put(ProductController(orderItem, productDetailModel, onChangeAmount, priceType));
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
    Get.delete<ProductController>(force: true);
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

  final RxBool _validate = false.obs;

  /// Frame yüklendiğinde [_initAfterProductDetailLoaded] i çağırmaktayiz
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    productDetailModel.initAfterProductDetailLoaded(orderItem: orderItem);
    amountUpdate();

    /// Getx pakat ile [_amount] i dinleyip [onChangeAmount] metodunu tetiklemekteyiz
    ever<double>(_amount, (value) {
      onChangeAmount(value);
    });
  }

  ProductController(this.orderItem, ProductDetailModel productDetailModel, this.onChangeAmount, this.priceType) {
    _productDetailModel = productDetailModel.obs;

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
    update(['productDetailModelUpdate']);
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
    productDetailModel.optionGroups![optionGroupsIndex].singleOptionSelection(selectedIndex);
    productDetailModel = productDetailModel;
    amountUpdate();
  }

  /// Tekli özelik Seçimlerde çalışan metod
  void singleFeatureSelection(int featureIndex, int selectedIndex) {
    productDetailModel.features![featureIndex].singleFeatureSelection(selectedIndex);
    productDetailModel = productDetailModel;
    amountUpdate();
  }

  /// Özelik Cıkarma section lerde çalışan metod.
  /// Birden fazla seçimlerde
  void multiDecreaseFeatureSelection(bool status, int featureIndex, int selectedIndex) {
    productDetailModel.features![featureIndex].multiDecreaseFeatureSelection(status, selectedIndex);
    productDetailModel = productDetailModel;
  }

  /// Opsiyon Cıkarma section lerde çalışan metod.
  /// Birden fazla seçimlerde
  void multiDecreaseOptionSelection(bool status, int optionGroupsIndex, int selectedIndex) {
    productDetailModel.optionGroups![optionGroupsIndex].multiDecreaseOptionSelection(status, selectedIndex);
    productDetailModel = productDetailModel;
  }

  /// Özelik Ekleme section lerde çalışan metod.
  /// Birden fazla seçimlerde.
  void multiAddFeatureSelection(bool status, int featureIndex, int selectedIndex) {
    productDetailModel.features![featureIndex].multiAddFeatureSelection(status, selectedIndex);
    productDetailModel = productDetailModel;
    amountUpdate();
  }

  /// Opsiyon Ekleme section lerde çalışan metod.
  /// Birden fazla seçimlerde.
  void multiAddOptionSelection(bool status, int optionGroupsIndex, int selectedIndex) {
    productDetailModel.optionGroups![optionGroupsIndex].multiAddOptionSelection(status, selectedIndex);
    productDetailModel = productDetailModel;
    amountUpdate();
  }

  /// Miktar buttonuna tıklandığı zaman çalışan metod
  void countUpdate(int _count) {
    amount = (amount / count) * _count;
    count = _count;
  }

  /// Secilen SECTION lere göre toplam tutarı güncellemekte
  void amountUpdate() {
    amount = productDetailModel.getTotalAmount(priceType: priceType, quantity: count);
  }

  /// Sepete Buttonuna tıklandığında tetiklenen Fon.
  ItemOrder? _getBasketModel(TimeoutAction timeoutAction) {
    try {
      final item = productDetailModel.getBasketModel(
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

  /// Daha önceden seçilen özelik index i Getirmek için yazıldı.
  /// isSelected alanını kontrol etmekte.
  int? getIndexForSelectedFeatureItem(int featureIndex) {
    final value = productDetailModel.features![featureIndex].items!.indexWhere((element) => element.isSelected);
    return value == -1 ? null : value;
  }

  /// Daha önceden seçilen opsiyon index i Getirmek için yazıldı.
  /// isSelected alanını kontrol etmekte.
  int? getIndexForSelectedOption(int optionGroupsIndex) {
    final value =
        productDetailModel.optionGroups![optionGroupsIndex].options!.indexWhere((element) => element.isSelected);
    return value == -1 ? null : value;
  }

  /// Note Dialog u kapandığında çalışan Fonk.
  /// Girilen Notu Text Field kontrollune attıyor.
  void onCloseNotDialog(String note) {
    cNote.text = note;
    debugPrint(note);
  }
}
