import 'package:example/Screen/ProductProfileScreen/View/product_detail_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/Screen/ProductProfileScreen/Controller/product_profile_controller.dart';

class ProductProfile extends StatefulWidget {
  ProductProfile({Key? key}) : super(key: key);

  @override
  State<ProductProfile> createState() => _ProductProfileState();
}

class _ProductProfileState extends State<ProductProfile> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductProfileController>();
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Theme.of(context).cardColor,
      body: ProductDetailSliverList(),
    );
  }
}
