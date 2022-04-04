import 'package:example/App/Widget/OtherWidgets/ProductProfileFeature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/App/Extension/GeneralExtension.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/Screen/ProductProfileScreen/Controller/product_profile_controller.dart';
import '../Widgets/product_title_and_detail.dart';
import '../Widgets/quantity_row_and_button.dart';
import 'package:product_detail/product_detail.dart';

class ProductDetails extends StatelessWidget {
  /// Ürün Section, Feature ve option lerini listeler

  ProductDetails({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<String> list = [];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductProfileController>();
    return Obx(() => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ürün Isim, Kısa Açıklama ve açıklama
        ProductTitleAndDetail(
            title: controller.itemObject.productName!,
            subTitle: controller.itemObject.shortDescription,
            detail: controller.productDetailModel.description,
          showCloseButton: controller.bottomSheetPosition == 1,
          ),
        SizedBox(height: paddingXXXS),
        controller.loadingStatus.isLoaded
              ? Column(
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
                    QuantityRowAndButton(),
                    Padding(
                          padding: const EdgeInsets.symmetric(horizontal: paddingM).copyWith(top: paddingM),
                          child: ProductDetailView(
                             controller: controller.optionViewController!,
                          ),
                        ),
                  ],
                ) : SizedBox(),
      ],
    ));
  }
}
