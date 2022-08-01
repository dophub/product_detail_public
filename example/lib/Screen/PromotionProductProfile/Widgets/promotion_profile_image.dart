import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:example/App/Widget/OtherWidgets/ImageListPositionsTag.dart';
import 'package:example/App/Widget/OtherWidgets/TSImageNetwork.dart';
import 'package:example/Screen/PromotionProductProfile/Controller/promotion_profile_controller.dart';
import 'package:sip_models/response.dart';

/// Ürün profilde ürün resimleri
/// Yatay kayan şeklinde
/// Alt kısımda hangi indexte olduğunu belirten noktalar
/// Sol üst kısımda close butonu mevcut
class PromotionProfileImage extends StatelessWidget {
  final List<ImagesModel> list;

  const PromotionProfileImage({Key? key, required this.list}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PromotionProfileController>();
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        /// Image List
        PageView.builder(
          itemCount: list.length,
          onPageChanged: (int value) {
            controller.imagePositionIndex = value;
          },
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              //onTap: ()=> controller.imageOnTap(list[index].imageUrl!),
              child: SizedBox(
                width: SizeConfig.screenWidth,
                child: TSImageNetwork(
                  imageUrl: list[index].imageUrl!,
                ),
              ),
            );
          },
        ),

        /// Image List Position Tag
       Positioned(
           bottom: paddingXXXL,
           child: Obx(() => ImageListPositionsTag(length: list.length,selectedIndex: controller.imagePositionIndex,)))
      ],
    );
  }
}

