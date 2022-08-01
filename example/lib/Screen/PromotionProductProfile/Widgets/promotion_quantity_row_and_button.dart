import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Button/QuantityButton.dart';
import 'package:example/Screen/PromotionProductProfile/Controller/promotion_profile_controller.dart';

class PromotionQuantityRowAndButton extends StatelessWidget {
  /// 'Adet yazısı - Miktar butonlar' şeklinde Row Widget
  const PromotionQuantityRowAndButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PromotionProfileController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingM),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Card(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingM),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Adet',
                  style: s16W400Dark(context),
                ),
                Obx(
                  () => QuantityButton(
                    quantity: controller.count,
                    onChange: controller.onTapQuantityBtn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
