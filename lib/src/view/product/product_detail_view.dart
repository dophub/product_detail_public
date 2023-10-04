import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_detail/extension.dart';
import 'package:product_detail/src/app/component/other/note_dialog.dart';
import 'package:product_detail/src/app/component/section/multi_section_check_box.dart';
import 'package:product_detail/src/app/component/section/product_decrise_section.dart';
import 'package:product_detail/src/app/component/section/single_Section_bottom_sheet.dart';
import 'package:product_detail/src/app/component/section/single_section_radio_button.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/controller/product_controller.dart';
import 'package:sip_models/enum.dart';
import 'package:sip_models/response.dart';

/// Ürün detayının View kısmınıdır
class ProductDetailView extends StatelessWidget {
  final ProductViewController controller;

  const ProductDetailView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      id: 'productDetailModelUpdate',
      builder: (ProductController controller) {
        return Column(
          children: [
            /// Product Option
            Padding(
              padding: EdgeInsets.only(bottom: controller.productDetailModel.optionGroups!.length == 0 ? 0 : paddingS),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.productDetailModel.optionGroups!.length,
                itemBuilder: (BuildContext context, int optionGroupsIndex) {
                  var optionGroup = controller.productDetailModel.optionGroups![optionGroupsIndex];
                  if (optionGroup.addingTypeId == AddingTypeId.SELECT.name &&
                      optionGroup.chooseTypeId == ChooseTypeId.SINGLE.name) {
                    /// Tekli Seçim
                    return SingleSectionRadioButton(
                      title: optionGroup.optionGroupName!,
                      subTitle: optionGroup.description,
                      selectedIndex: controller.productDetailModel.optionGroups![optionGroupsIndex].options!
                          .getIndexForSelectedOption(),
                      onTap: (int selectedIndex) => controller.singleOptionSelection(optionGroupsIndex, selectedIndex),
                      list: optionGroup.options!,
                      showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                    );
                  } else if (optionGroup.addingTypeId == describeEnum(AddingTypeId.DECREASE) &&
                      optionGroup.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                    /// Çoklu Çıkarma
                    return MultiSectionDecreaseSection(
                      title: optionGroup.optionGroupName!,
                      subTitle: optionGroup.description,
                      onTap: (OptionModel obj, int selectedIndex) =>
                          controller.multiDecreaseOptionSelection(obj.getStatus, optionGroupsIndex, selectedIndex),
                      list: optionGroup.options!,
                      showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                    );
                  } else if (optionGroup.addingTypeId == describeEnum(AddingTypeId.ADD) &&
                      optionGroup.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                    /// Tekli Ekleme
                    return SingleSectionBottomSheet(
                      title: optionGroup.optionGroupName!,
                      subTitle: optionGroup.description,
                      list: optionGroup.options!,
                      hintText: 'Seçiniz',
                      selectedIndex: controller.productDetailModel.optionGroups![optionGroupsIndex].options!
                          .getIndexForSelectedOption(),
                      onTap: (int selectedIndex) => controller.singleOptionSelection(optionGroupsIndex, selectedIndex),
                      showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                    );
                  } else if ((optionGroup.addingTypeId == describeEnum(AddingTypeId.ADD) ||
                          optionGroup.addingTypeId == describeEnum(AddingTypeId.SELECT)) &&
                      optionGroup.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                    /// Çoklu Ekleme
                    /// Tekli Seçme
                    return MultiSectionCheckBox(
                      title: optionGroup.optionGroupName!,
                      subTitle: optionGroup.description,
                      list: optionGroup.options!,
                      onTap: (bool value, int selectedIndex) =>
                          controller.multiAddOptionSelection(value, optionGroupsIndex, selectedIndex),
                      maxSection: optionGroup.maxCount,
                      showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: paddingS);
                },
              ),
            ),

            /// Product Features
            Padding(
              padding: EdgeInsets.only(bottom: controller.productDetailModel.features!.length == 0 ? 0 : paddingS),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.productDetailModel.features!.length,
                itemBuilder: (BuildContext context, int featureIndex) {
                  var features = controller.productDetailModel.features![featureIndex];
                  if (features.addingTypeId == describeEnum(AddingTypeId.SELECT) &&
                      features.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                    /// Tekli Seçme
                    return SingleSectionRadioButton(
                      title: features.featureName!,
                      subTitle: features.description,
                      selectedIndex:
                          controller.productDetailModel.features![featureIndex].items!.getIndexForSelectedFeatureItem(),
                      onTap: (int selectedIndex) => controller.singleFeatureSelection(featureIndex, selectedIndex),
                      list: features.items!,
                      showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                    );
                  } else if (features.addingTypeId == describeEnum(AddingTypeId.DECREASE) &&
                      features.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                    /// Çoklu Çıkarma
                    return MultiSectionDecreaseSection(
                      title: features.featureName!,
                      subTitle: '(Lütfen çıkarnak istediğiniz ürünleri seçinniz)',
                      onTap: (ItemModel obj, int selectedIndex) =>
                          controller.multiDecreaseFeatureSelection(obj.getStatus, featureIndex, selectedIndex),
                      list: features.items!,
                      showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                    );
                  } else if (features.addingTypeId == describeEnum(AddingTypeId.ADD) &&
                      features.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                    /// Tekli Ekleme
                    return SingleSectionBottomSheet(
                      title: features.featureName!,
                      subTitle: features.description!,
                      list: features.items!,
                      hintText: 'Seçiniz',
                      selectedIndex:
                          controller.productDetailModel.features![featureIndex].items!.getIndexForSelectedFeatureItem(),
                      onTap: (int selectedIndex) => controller.singleFeatureSelection(featureIndex, selectedIndex),
                      showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                    );
                  } else if ((features.addingTypeId == describeEnum(AddingTypeId.ADD) ||
                          features.addingTypeId == describeEnum(AddingTypeId.SELECT)) &&
                      features.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                    /// Çoklu Ekleme
                    /// Çoklu Seçme
                    return MultiSectionCheckBox(
                      title: features.featureName!,
                      subTitle: features.description!,
                      list: features.items!,
                      onTap: (bool value, int selectedIndex) =>
                          controller.multiAddFeatureSelection(value, featureIndex, selectedIndex),
                      maxSection: features.maxCount,
                      showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: paddingS);
                },
              ),
            ),
            GestureDetector(
              child: GestureDetector(
                onTap: () {
                  NoteDialog().showMenuDialog(
                    context,
                    text: controller.cNote.text,
                    onClose: controller.onCloseNotDialog,
                  );
                },
                child: TextFormField(
                  controller: controller.cNote,
                  decoration:
                      InputDecoration(hintText: 'Ürün Notu', fillColor: Theme.of(context).colorScheme.background),
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 3,
                  enabled: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
