import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sip_models/enum.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Extension/GeneralExtension.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:example/App/Widget/Button/AddToCartButton.dart';
import 'package:example/Screen/ProductProfileScreen/Controller/product_profile_controller.dart';
import 'product_details.dart';
import '../Widgets/product_profile_image.dart';

/// Ürün detayını gösteren bottom sheet
/// Ürün Resimleri
class ProductDetailBottomSheet extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductProfileController>();
    final SnappingPosition minPosition = SnappingPosition.pixels(
      snappingCurve: Curves.decelerate,
      /// Ekranın 3 te ikisini kaplayacak şekilde
      positionPixels: (SizeConfig.screenHeight / 3 * 2),
      grabbingContentOffset: GrabbingContentOffset.top,
    );
    return SnappingSheet(
      lockOverflowDrag: true,
      initialSnappingPosition: minPosition,
      controller: controller.bottomSheetScrollController,
      onSheetMoved: (positionData) {
        print(positionData.relativeToSheetHeight);
        controller.bottomSheetPosition = positionData.relativeToSheetHeight;
      },
      snappingPositions: [
        SnappingPosition.pixels(
          snappingCurve: Curves.decelerate,
          positionPixels: SizeConfig.screenHeight,
          grabbingContentOffset: GrabbingContentOffset.bottom,
        ),
        minPosition,
      ],
      /// Bottom Sheet background
      child: Column(
        children: [
          Container(
            height: SizeConfig.statusBarHeight,
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
          SizedBox(
            /// radiusL yi eklememizin sebebi bottom sheetin yan taraflarının radius i olmasından dolayı
            /// Ekranın 3 te birini kaplayacak şekilde
            height: (SizeConfig.screenHeight / 3) + radiusXL,
            child: ProductProfileImage(
              list: controller.imagesList,
            ),
          ),
        ],
      ),
      /// Bottom Sheet Foreground
      sheetBelow: SnappingSheetContent(
        childScrollController: _scrollController,
        draggable: true,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.statusBarHeight),
            Expanded(child: ProductDetails(scrollController: _scrollController)),
            Padding(
              padding: EdgeInsets.only(bottom: SizeConfig.safeAreaPadding.bottom),
              child: Obx(
                () => AddToCartButton(
                  text: controller.orderItem == null ? null : 'Sepeti Güncelle',
                  price: controller.amount,
                  onTap: controller.loadingStatus.isLoaded
                      ? () => controller.onTapAddToCartBtn(TimeoutAction.None)
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
