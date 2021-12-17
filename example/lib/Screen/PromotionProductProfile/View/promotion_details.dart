import 'package:example/App/Widget/OtherWidgets/ProductProfileFeature.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/App/Extension/GeneralExtension.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/Screen/PromotionProductProfile/Controller/promotion_profile_controller.dart';
import '../Widgets/promotion_title_and_detail.dart';
import '../Widgets/promotion_quantity_row_and_button.dart';
import 'package:product_detail/product_detail.dart';

class PromotionDetails extends StatelessWidget {
  /// Ürün Section, Feature ve option lerini listeler

  PromotionDetails({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<String> list = [];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PromotionProfileController>();
    return Obx(() => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ürün Isim, Kısa Açıklama ve açıklama
        PromotionTitleAndDetail(
            title: controller.itemObject.productName!,
            subTitle: controller.itemObject.shortDescription,
            detail: controller.promotionMenuModel.description,
          showCloseButton: controller.bottomSheetPosition == 1,
          ),
        SizedBox(height: paddingXXXS),
        controller.loadingStatus.isLoaded ? Column(
                  children: [
                    Visibility(
                        visible: controller.itemObject.makeTime != 0 &&
                            controller.itemObject.makeTime != 0 && list.length != 0,
                        child: ProductProfileFeature(
                          list: list,
                          makeTime: controller.itemObject.makeTime,
                          calorie: controller.itemObject.calorie,
                        ),
                    ),
                    SizedBox(height: paddingM),
                    // Miktar Button
                    PromotionQuantityRowAndButton(),
                    // Promotion ürün ise
                    PromotionProductDetailView(controller: controller.optionViewController!),
                  ],
                ):SizedBox()
      ],
    ));
  }
}
