import 'package:example/Screen/PromotionProductProfile/View/promotion_detail_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/Screen/PromotionProductProfile/Controller/promotion_profile_controller.dart';

class PromotionProfile extends StatefulWidget {
  PromotionProfile({Key? key}) : super(key: key);

  @override
  State<PromotionProfile> createState() => _PromotionProfileState();
}

class _PromotionProfileState extends State<PromotionProfile> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PromotionProfileController>();
    return Scaffold(
      key: controller.scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      body: PromotionDetailSliverList(),
    );
  }
}
