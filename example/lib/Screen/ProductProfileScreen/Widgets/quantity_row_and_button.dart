import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/Screen/ProductProfileScreen/Controller/product_profile_controller.dart';
import 'package:example/App/Widget/Button/QuantityButton.dart';

class QuantityRowAndButton extends StatelessWidget {
  /// 'Adet yazısı - Miktar butonlar' şeklinde Row Widget
  const QuantityRowAndButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductProfileController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingM),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Card(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingM),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
