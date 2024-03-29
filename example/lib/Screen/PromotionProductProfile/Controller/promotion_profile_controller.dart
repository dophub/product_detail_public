import 'package:example/App/BL/General.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:example/App/Constant/Enums/IdEnum.dart';
import 'package:example/App/Extension/GeneralExtension.dart';
import 'package:example/App/Constant/Enums/LoadingStatusEnum.dart';
import 'package:example/App/Controller/controller.dart';
import 'package:get/get.dart';
import 'package:product_detail/model.dart';
import 'package:example/Core/Service/CheckInternet.dart';
import 'package:example/App/Model/Response/BaseHttpModel.dart';
import 'package:example/App/Widget/Message/ToastMessage.dart';
import 'package:example/App/Widget/Dialog/LoadingProgress.dart';
import 'package:product_detail/controller.dart';
import 'package:product_detail/general_controller.dart';


class PromotionProfileController extends GetxController {
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  late Rx<LoadingStatus> _loadingStatus;
  late Rx<PromotionMenuModel> _promotionMenuModel;
  late final int dealerId;
  late OrderItem? orderItem;
  late Rx<double> _amount;
  late Rx<int> _imagePositionIndex;
  final SnappingSheetController bottomSheetScrollController = SnappingSheetController();
  late Rx<double> _bottomSheetPosition;
  late List<ImagesModel> imagesList;
  late MenuProductModel itemObject;
  late Rx<int> _count;
  PromotionViewController? optionViewController;
  late Rx<bool> _flexibleSpaceBarClosed;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ready();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final mainController = Get.find<Controller>();
    imagesList = mainController.getImages(itemObject.images!,ImageSizeId.mobile_detail);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    optionViewController?.dispose();
    super.onClose();
  }

  PromotionProfileController(this.dealerId,this.itemObject, this.orderItem) {
    _loadingStatus = LoadingStatus.Init.obs;
    _promotionMenuModel = PromotionMenuModel().obs;
    _amount = 0.0.obs;
    _imagePositionIndex = 0.obs;
    _count = orderItem == null ? 1.obs : orderItem!.count!.obs;
    _bottomSheetPosition = 0.0.obs;
    imagesList = <ImagesModel>[];
    _flexibleSpaceBarClosed = false.obs;
  }


  bool get flexibleSpaceBarClosed => _flexibleSpaceBarClosed.value;

  set flexibleSpaceBarClosed(bool value) {
    if (_flexibleSpaceBarClosed.value != value && SchedulerBinding.instance!.schedulerPhase != SchedulerPhase.idle) {
      SchedulerBinding.instance!.endOfFrame.then((_) => _flexibleSpaceBarClosed.value = value);
    }
  }

  int get count => _count.value;

  set count(int value) {
    _count.value = value;
  }

  double get bottomSheetPosition => _bottomSheetPosition.value;

  set bottomSheetPosition(double value) {
    _bottomSheetPosition.value = value;
  }

  int get imagePositionIndex => _imagePositionIndex.value;

  set imagePositionIndex(int value) {
    _imagePositionIndex.value = value;
  }

  double get amount => _amount.value;

  set amount(double value) {
    _amount.value = value;
  }

  LoadingStatus get loadingStatus => _loadingStatus.value;

  set loadingStatus(LoadingStatus value) {
    _loadingStatus.value = value;
  }


  PromotionMenuModel get promotionMenuModel => _promotionMenuModel.value;

  set promotionMenuModel(PromotionMenuModel value) {
    _promotionMenuModel.value = value;
    update();
  }

  Future<void> _getProductDetails() async {
    BuildContext context = scaffoldKey.currentContext!;
    try {
      if (await checkInternet(context)) {
        loadingStatus = LoadingStatus.Loading;
        BaseHttpModel response = await General().getPromotionDetail(dealerId, itemObject.id!);
        if (response.status.isOk) {
          loadingStatus = LoadingStatus.Loaded;
          promotionMenuModel = response.data!;
          optionViewController = PromotionViewController(orderItem,promotionMenuModel,PriceType.TABLE);
          optionViewController!.addListener(() {
            amount = optionViewController!.value;
          });
          loadingStatus = LoadingStatus.Loaded;
        } else {
          loadingStatus = LoadingStatus.Error;
          showToastMessage(context, textMessage: response.message ?? 'Hata');
        }
      }
    } catch (e) {}
  }

  /// Ekran yüklendikten sonra çalışan metod
  Future<void> ready() async {
    BuildContext context = scaffoldKey.currentState!.context;
    amount = ProductDetailGeneralController().getPrice(PriceType.TABLE,itemObject.price!);
    LoadingProgress.showLoading(context);
    await _getProductDetails();
    LoadingProgress.done(context);
    getImagesFromModel();
  }

  /// Miktar buttonuna tıklandığı zaman çalışan metod
  void onTapQuantityBtn(int _count) {
    count = _count;
    optionViewController!.count = _count;
  }

  /// Api den Gelen response teki resim listesinden Size Id si [ImageSizeId.mobile_detail] olan cekiyor.
  /// Ekran init olduğunda bi önceki ekrandan gelen modelden image i alıp listeye atıp ekranda bu resim gösteriliyor.
  /// Daha sonra Api den Response döndüğünde gelen response ten Images i alıp bi önceki ekrandan gelen resmin id olan resimleri bu listeden silip
  /// Daha sonra images listemize ekliyor böylece bi önceki ekrandan gelen ve göstermekte olduğumuz resim etkilenmeyip
  ///  Response ten gelen resimler üzerine eklenmekte.
  void getImagesFromModel() {
    final mainController = Get.find<Controller>();
    if (loadingStatus.isLoaded){
        List<ImagesModel> list = mainController.getImages(promotionMenuModel.images!,ImageSizeId.mobile_detail);
        list.removeWhere((ImagesModel element) => element.id == imagesList[0].id);
        imagesList = imagesList + list;
    }
  }

  /// Sepete Buttonuna tıklandığında tetiklenen Fon.
  Future<void> onTapAddToCartBtn(TimeoutAction timeoutAction) async {
    BuildContext context = scaffoldKey.currentContext!;
    LoadingProgress.showLoading(context);
    var item = optionViewController!.getBasketModel(TimeoutAction.Add);
    await Future.delayed(Duration(seconds: 1));// Http işlemi
    LoadingProgress.done(context);
    showToastMessage(context,textMessage: 'Ürün sepete eklendi');
  }

  void onScroll(context, BoxConstraints constraints) {
    if (constraints.biggest.height - (SizeConfig.appBarHeight + SizeConfig.statusBarHeight) < 1
        && constraints.biggest.height - (SizeConfig.appBarHeight + SizeConfig.statusBarHeight) > -1) {
      flexibleSpaceBarClosed = true;
    } else {
      flexibleSpaceBarClosed = false;
    }
  }
}
