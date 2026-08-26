import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_detail/extension.dart';
import 'package:product_detail/src/app/component/section/multi_section_check_box.dart';
import 'package:product_detail/src/app/component/section/product_decrise_section.dart';
import 'package:product_detail/src/app/component/section/single_Section_bottom_sheet.dart';
import 'package:product_detail/src/app/component/section/single_section_radio_button.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/controller/promotion_controller.dart';
import 'package:sip_models/enum.dart';
import 'package:sip_models/response.dart';

import '../../app/component/section/multi_section_card.dart';
import '../../app/i10n/i10n.dart';

/// product optionGroups
class PromotionFeatureAndOption extends StatelessWidget {
  final List<OptionGroupModel> optionGroupsList;
  final int sectionIndex;
  final List<FeatureModel> featuresList;

  const PromotionFeatureAndOption({
    super.key,
    required this.optionGroupsList,
    required this.featuresList,
    this.sectionIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PromotionController>();
    return Column(
      children: [
        /// Product Option
        Padding(
          padding: EdgeInsets.only(top: optionGroupsList.length == 0 ? 0 : paddingXS),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: optionGroupsList.length,
            itemBuilder: (BuildContext context, int optionGroupsIndex) {
              var optionGroup = optionGroupsList[optionGroupsIndex];
              if (optionGroup.addingTypeId == AddingTypeId.SELECT.name && optionGroup.chooseTypeId == ChooseTypeId.SINGLE.name) {
                /// Tekli Seçim
                return SingleSectionRadioButton(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  selectedIndex: controller.promotionMenuModel.sections![sectionIndex]
                      .getIndexForSelectedOption(optionGroupsIndex),
                  onTap: (int selectedIndex) =>
                      controller.singleOptionSelection(sectionIndex, optionGroupsIndex, selectedIndex),
                  list: optionGroup.options!,
                  showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                );
              } else if (optionGroup.addingTypeId == AddingTypeId.DECREASE.name && optionGroup.chooseTypeId == ChooseTypeId.MULTIPLE.name) {
                /// Çoklu Çıkarma
                return MultiSectionDecreaseSection(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  onTap: (OptionModel obj, int selectedIndex) => controller.multiDecreaseOptionSelection(
                      sectionIndex, obj.getStatus, optionGroupsIndex, selectedIndex),
                  list: optionGroup.options!,
                  showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                );
              } else if (optionGroup.addingTypeId == AddingTypeId.ADD.name && optionGroup.chooseTypeId == ChooseTypeId.SINGLE.name) {
                /// Tekli Ekleme
                return SingleSectionBottomSheet(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  list: optionGroup.options!,
                  hintText: AppLocalization.getLabels(context).select,
                  selectedIndex: controller.promotionMenuModel.sections![sectionIndex]
                      .getIndexForSelectedOption(optionGroupsIndex),
                  onTap: (int selectedIndex) =>
                      controller.singleOptionSelection(sectionIndex, optionGroupsIndex, selectedIndex),
                  showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                );
              } else if (optionGroup.addingTypeId == AddingTypeId.SELECT.name && optionGroup.chooseTypeId == ChooseTypeId.MULTIPLE.name) {
                /// Tekli Seçme
                return MultiSectionCheckBox(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  list: optionGroup.options!,
                  onTap: (bool value, int selectedIndex) =>
                      controller.multiAddOptionSelection(sectionIndex, value, optionGroupsIndex, selectedIndex),
                  maxSection: optionGroup.maxCount,
                  showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                );
              } else if (optionGroup.addingTypeId == AddingTypeId.ADD.name && optionGroup.chooseTypeId == ChooseTypeId.MULTIPLE.name) {
                /// Çoklu Ekleme
                return MultiSectionCard(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  list: optionGroup.options!,
                  onTap: (bool value, int selectedIndex) =>
                      controller.multiAddOptionSelection(sectionIndex, value, optionGroupsIndex, selectedIndex),
                  maxSection: optionGroup.maxCount,
                  showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                );
              } else {
                return const SizedBox();
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: paddingXS);
            },
          ),
        ),

        /// Product Features
        Padding(
          padding: EdgeInsets.only(top: featuresList.length == 0 ? 0 : paddingXS),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: featuresList.length,
            itemBuilder: (BuildContext context, int featureIndex) {
              var features = featuresList[featureIndex];
              if (features.addingTypeId == AddingTypeId.SELECT.name && features.chooseTypeId == ChooseTypeId.SINGLE.name) {
                /// Tekli Seçme
                return SingleSectionRadioButton(
                  title: features.featureName!,
                  subTitle: features.description,
                  selectedIndex: controller.promotionMenuModel.sections![sectionIndex]
                      .getIndexForSelectedFeatureItem(featureIndex),
                  onTap: (int selectedIndex) =>
                      controller.singleFeatureSelection(sectionIndex, featureIndex, selectedIndex),
                  list: features.items!,
                  showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                );
              } else if (features.addingTypeId == AddingTypeId.DECREASE.name && features.chooseTypeId == ChooseTypeId.MULTIPLE.name) {
                /// Çoklu Çıkarma
                return MultiSectionDecreaseSection(
                  title: features.featureName!,
                  subTitle: '(${AppLocalization.getLabels(context).selectProductsToRemove})',
                  onTap: (ItemModel obj, int selectedIndex) => controller.multiDecreaseFeatureSelection(
                      sectionIndex, obj.getStatus, featureIndex, selectedIndex),
                  list: features.items!,
                  showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                );
              } else if (features.addingTypeId == AddingTypeId.ADD.name && features.chooseTypeId == ChooseTypeId.SINGLE.name) {
                /// Tekli Ekleme
                return SingleSectionBottomSheet(
                  title: features.featureName!,
                  subTitle: features.description!,
                  list: features.items!,
                  hintText: AppLocalization.getLabels(context).select,
                  selectedIndex: controller.promotionMenuModel.sections![sectionIndex]
                      .getIndexForSelectedFeatureItem(featureIndex),
                  onTap: (int selectedIndex) =>
                      controller.singleFeatureSelection(sectionIndex, featureIndex, selectedIndex),
                  showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                );
              } else if ( features.addingTypeId == AddingTypeId.SELECT.name && features.chooseTypeId == ChooseTypeId.MULTIPLE.name) {
                /// Çoklu Ekleme
                /// Çoklu Seçme
                return MultiSectionCheckBox(
                  title: features.featureName!,
                  subTitle: features.description!,
                  list: features.items!,
                  onTap: (bool value, int selectedIndex) =>
                      controller.multiAddFeatureSelection(sectionIndex, value, featureIndex, selectedIndex),
                  maxSection: features.maxCount,
                  showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                );
              } else if (features.addingTypeId == AddingTypeId.ADD.name  && features.chooseTypeId == ChooseTypeId.MULTIPLE.name) {
                /// Çoklu Ekleme
                /// Çoklu Seçme
                return MultiSectionCard(
                  title: features.featureName!,
                  subTitle: features.description!,
                  list: features.items!,
                  onTap: (bool value, int selectedIndex) =>
                      controller.multiAddFeatureSelection(sectionIndex, value, featureIndex, selectedIndex),
                  maxSection: features.maxCount,
                  showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                );
              } else {
                return const SizedBox();
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: paddingXS);
            },
          ),
        ),
      ],
    );
  }
}
