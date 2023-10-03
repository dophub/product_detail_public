import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_detail/src/app/component/section/multi_section_check_box.dart';
import 'package:product_detail/src/app/component/section/product_decrise_section.dart';
import 'package:product_detail/src/app/component/section/single_Section_bottom_sheet.dart';
import 'package:product_detail/src/app/component/section/single_section_radio_button.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/controller/promotion_controller.dart';
import 'package:sip_models/enum.dart';
import 'package:sip_models/response.dart';

/// product optionGroups
class PromotionFeatureAndOption extends StatelessWidget {
  final List<OptionGroupModel> optionGroupsList;
  final int sectionIndex;
  final List<FeatureModel> featuresList;

  const PromotionFeatureAndOption({
    Key? key,
    required this.optionGroupsList,
    required this.featuresList,
    this.sectionIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PromotionController>();
    return Column(
      children: [
        /// Product Option
        Padding(
          padding: EdgeInsets.only(top: optionGroupsList.length == 0 ? 0 : paddingS),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: optionGroupsList.length,
            itemBuilder: (BuildContext context, int optionGroupsIndex) {
              var optionGroup = optionGroupsList[optionGroupsIndex];
              if (optionGroup.addingTypeId == describeEnum(AddingTypeId.SELECT) &&
                  optionGroup.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                /// Tekli Seçim
                return SingleSectionRadioButton(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  selectedIndex: controller.getIndexForSelectedOption(sectionIndex, optionGroupsIndex),
                  onTap: (int selectedIndex) =>
                      controller.singleOptionSelection(sectionIndex, optionGroupsIndex, selectedIndex),
                  list: optionGroup.options!,
                  showErrorOutline: controller.validate && !optionGroup.isSelected && optionGroup.isRequire!,
                );
              } else if (optionGroup.addingTypeId == describeEnum(AddingTypeId.DECREASE) &&
                  optionGroup.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                /// Çoklu Çıkarma
                return MultiSectionDecreaseSection(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  onTap: (OptionModel obj, int selectedIndex) => controller.multiDecreaseOptionSelection(
                      sectionIndex, obj.getStatus, optionGroupsIndex, selectedIndex),
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
                  selectedIndex: controller.getIndexForSelectedOption(sectionIndex, optionGroupsIndex),
                  onTap: (int selectedIndex) =>
                      controller.singleOptionSelection(sectionIndex, optionGroupsIndex, selectedIndex),
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
                      controller.multiAddOptionSelection(sectionIndex, value, optionGroupsIndex, selectedIndex),
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
          padding: EdgeInsets.only(top: featuresList.length == 0 ? 0 : paddingS),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: featuresList.length,
            itemBuilder: (BuildContext context, int featureIndex) {
              var features = featuresList[featureIndex];
              if (features.addingTypeId == describeEnum(AddingTypeId.SELECT) &&
                  features.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                /// Tekli Seçme
                return SingleSectionRadioButton(
                  title: features.featureName!,
                  subTitle: features.description,
                  selectedIndex: controller.getIndexForSelectedFeatureItem(sectionIndex, featureIndex),
                  onTap: (int selectedIndex) =>
                      controller.singleFeatureSelection(sectionIndex, featureIndex, selectedIndex),
                  list: features.items!,
                  showErrorOutline: controller.validate && !features.isSelected && features.isRequire!,
                );
              } else if (features.addingTypeId == describeEnum(AddingTypeId.DECREASE) &&
                  features.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                /// Çoklu Çıkarma
                return MultiSectionDecreaseSection(
                  title: features.featureName!,
                  subTitle: '(Lütfen çıkarnak istediğiniz ürünleri seçinniz)',
                  onTap: (ItemModel obj, int selectedIndex) => controller.multiDecreaseFeatureSelection(
                      sectionIndex, obj.getStatus, featureIndex, selectedIndex),
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
                  selectedIndex: controller.getIndexForSelectedFeatureItem(sectionIndex, featureIndex),
                  onTap: (int selectedIndex) =>
                      controller.singleFeatureSelection(sectionIndex, featureIndex, selectedIndex),
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
                      controller.multiAddFeatureSelection(sectionIndex, value, featureIndex, selectedIndex),
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
      ],
    );
  }
}
