import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Button/TSCloseButton.dart';
import 'package:example/Screen/PromotionProductProfile/Controller/promotion_profile_controller.dart';
import 'package:example/Screen/PromotionProductProfile/View/promotion_details.dart';
import 'package:example/Screen/PromotionProductProfile/Widgets/promotion_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/App/Extension/GeneralExtension.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:example/App/Widget/Button/AddToCartButton.dart';
import 'package:sip_models/sip_enum.dart';

class PromotionDetailSliverList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  PromotionDetailSliverList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PromotionProfileController>();
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                leading: TSCloseButton(),
                pinned: true,
                elevation: 0,
                expandedHeight: SizeConfig.screenHeight / 3,
                title: Obx(
                  () => controller.flexibleSpaceBarClosed
                      ? Text(
                          'Ürün Detayı',
                          style: s16W700Dark(context)
                              .copyWith(color: Colors.white),
                        )
                      : SizedBox(),
                ),
                flexibleSpace: LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                      controller.onScroll(context, constraints);
                      return Stack(
                    children: [
                      FlexibleSpaceBar(
                        background: Padding(
                          padding:
                              EdgeInsets.only(top: SizeConfig.statusBarHeight),
                          child: SizedBox(
                            height: SizeConfig.screenHeight / 3,
                            child: PromotionProfileImage(
                              list: controller.imagesList,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          height: SizeConfig.statusBarHeight),
                    ],
                  );
                }),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                        constraints: BoxConstraints(
                          minHeight: SizeConfig.screenHeight -
                              SizeConfig.safeAreaPadding.bottom -
                              SizeConfig.safeAreaPadding.top -
                              SizeConfig.appBarHeight -
                              SizeConfig.blockSizeHorizontal * 18 - 15,
                        ),
                        child: PromotionDetails(
                            scrollController: _scrollController)),
                    SizedBox(height: 15)
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.safeAreaPadding.bottom),
          child: Obx(
            () => SizedBox(
              height: SizeConfig.blockSizeHorizontal * 18,
              child: AddToCartButton(
                text: controller.orderItem == null ? null : 'Sepeti Güncelle',
                price: controller.amount,
                onTap: controller.loadingStatus.isLoaded
                    ? () => controller.onTapAddToCartBtn(TimeoutAction.None)
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TSDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;

  TSDelegate({required this.widget});

  //Profil alt Appbarı 'SliverPersistentHeader' olarak kullanmak için
  // 'SliverPersistentHeaderDelegate' ten extends edip kullanıyoruz
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Center(
      child: Column(
        children: [
          widget,
        ],
      ),
    );
  }

  @override
  double get maxExtent => 65;

  @override
  double get minExtent => 65;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
