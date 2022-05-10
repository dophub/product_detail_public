/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/App/Constant/Enums/IdEnum.dart';
import 'package:example/App/Widget/Section/multi_section_check_box.dart';
import 'package:example/App/Widget/Section/product_decrise_section.dart';
import 'package:example/App/Widget/Section/single_Section_bottom_sheet.dart';
import 'package:example/App/Widget/Section/single_section_radio_button.dart';
import 'package:example/App/Constant/App/padding_and_radius_size.dart';
import 'package:example/Screen/PromotionProductProfile/Controller/promotion_profile_controller.dart';
import 'package:product_detail/model.dart';

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
    final controller = Get.find<PromotionProfileController>();
    return Column(
      children: [
        /// product Option
        Padding(
          padding: EdgeInsets.only(bottom: optionGroupsList.length == 0 ? 0 :paddingM),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: optionGroupsList.length,
            itemBuilder: (BuildContext context, int optionGroupsIndex) {
              var optionGroup = optionGroupsList[optionGroupsIndex];
              if (optionGroup.addingTypeId == describeEnum(AddingTypeId.SELECT) && optionGroup.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                /// Tekli Seçim
                return SingleSectionRadioButton(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  selectedIndex: controller.getIndexForSelectedOption(sectionIndex,optionGroupsIndex),
                  onTap: (int selectedIndex) => controller.singleOptionSelection(sectionIndex, optionGroupsIndex, selectedIndex),
                  list: List.generate(optionGroup.options!.length, (index) =>
                      SectionsWidgetModel(
                          name: optionGroup.options![index].optionName!,
                          price: optionGroup.options![index].isFree! ? null : optionGroup.options![index].addPrice,
                      ),
                  ),
                );
              } else if (optionGroup.addingTypeId == describeEnum(AddingTypeId.DECREASE) && optionGroup.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                /// Çoklu Çıkarma
                return MultiSectionDecreaseSection(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  onTap: (SectionsWidgetModel obj, int selectedIndex) => controller.multiDecreaseOptionSelection(sectionIndex,obj.status!,optionGroupsIndex, selectedIndex),
                  list: List.generate(optionGroup.options!.length, (index) =>
                      SectionsWidgetModel(
                        name: optionGroup.options![index].optionName!,
                        status: optionGroup.options![index].isSelected,
                        price: 0,
                      ),
                  ),
                );
              } else if (optionGroup.addingTypeId == describeEnum(AddingTypeId.ADD) && optionGroup.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                /// Tekli Ekleme
                return SingleSectionBottomSheet(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  list: List.generate(optionGroup.options!.length, (index) =>
                      SectionsWidgetModel(
                          name:optionGroup.options![index].optionName!,
                          price: optionGroup.options![index].isFree! ? null : optionGroup.options![index].addPrice
                      ),
                  ),
                  hintText: 'Seçiniz',
                  selectedIndex: controller.getIndexForSelectedOption(sectionIndex,optionGroupsIndex),
                  onTap: (int selectedIndex) => controller.singleOptionSelection(sectionIndex, optionGroupsIndex, selectedIndex),
                );
              } else if ((optionGroup.addingTypeId == describeEnum(AddingTypeId.ADD) || optionGroup.addingTypeId == describeEnum(AddingTypeId.SELECT)) && optionGroup.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                /// Çoklu Ekleme
                /// Tekli Seçme
                return MultiSectionCheckBox(
                  title: optionGroup.optionGroupName!,
                  subTitle: optionGroup.description,
                  list: List.generate(optionGroup.options!.length, (index) =>
                      SectionsWidgetModel(
                          name: optionGroup.options![index].optionName!,
                          status: optionGroup.options![index].isSelected,
                          price: optionGroup.options![index].isFree! ? null : optionGroup.options![index].addPrice,
                      ),
                  ),
                  onTap: (bool value, int selectedIndex) => controller.multiAddOptionSelection(sectionIndex,value,optionGroupsIndex, selectedIndex),
                  maxSection: optionGroup.maxCount,
                );
              } else
                return SizedBox();
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: paddingM);
            },
          ),
        ),
        /// product Features
        Padding(
          padding: EdgeInsets.only(bottom:  featuresList.length == 0 ? 0 :paddingM),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: featuresList.length,
            itemBuilder: (BuildContext context, int featureIndex) {
              var features = featuresList[featureIndex];
              if (features.addingTypeId == describeEnum(AddingTypeId.SELECT) && features.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                /// Tekli Seçme
                return SingleSectionRadioButton(
                  title: features.featureName!,
                  subTitle: features.description,
                  selectedIndex: controller.getIndexForSelectedFeatureItem(sectionIndex,featureIndex),
                  onTap: (int selectedIndex) => controller.singleFeatureSelection(sectionIndex, featureIndex, selectedIndex),
                  list: List.generate(features.items!.length, (index) =>
                      SectionsWidgetModel(
                          name: features.items![index].productName!,
                          price: features.items![index].isFree! ? null : features.items![index].addPrice,
                      ),
                  ),
                );
              }
              else if (features.addingTypeId == describeEnum(AddingTypeId.DECREASE) && features.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                /// Çoklu Çıkarma
                return MultiSectionDecreaseSection(
                   title: features.featureName!,
                   subTitle: '(Lütfen çıkarnak istediğiniz ürünleri seçinniz)',
                   onTap: (SectionsWidgetModel obj, int selectedIndex) => controller.multiDecreaseFeatureSelection(sectionIndex,obj.status!,featureIndex, selectedIndex),
                   list: List.generate(features.items!.length, (index) =>
                       SectionsWidgetModel(
                         name: features.items![index].productName!,
                         status: features.items![index].isSelected,
                       ),
                   ),
                 );
              }
              else if (features.addingTypeId == describeEnum(AddingTypeId.ADD) && features.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                /// Tekli Ekleme
                return SingleSectionBottomSheet(
                  title: features.featureName!,
                  subTitle: features.description!,
                  list: List.generate(features.items!.length, (index) =>
                      SectionsWidgetModel(
                        name: features.items![index].productName!,
                        price: features.items![index].isFree! ? null :features.items![index].addPrice,
                      ),
                  ),
                  hintText: 'Seçiniz',
                  selectedIndex: controller.getIndexForSelectedFeatureItem(sectionIndex,featureIndex),
                  onTap: (int selectedIndex) => controller.singleFeatureSelection(sectionIndex, featureIndex, selectedIndex),
                );
              }
              else if ((features.addingTypeId == describeEnum(AddingTypeId.ADD) || features.addingTypeId == describeEnum(AddingTypeId.SELECT)) && features.chooseTypeId == describeEnum(ChooseTypeId.MULTIPLE)) {
                /// Çoklu Ekleme
                /// Çoklu Seçme
                return MultiSectionCheckBox(
                  title: features.featureName!,
                  subTitle: features.description!,
                  list: List.generate(features.items!.length, (index) =>
                      SectionsWidgetModel(
                        name: features.items![index].productName!,
                        status: features.items![index].isSelected,
                        price: features.items![index].isFree! ? null :features.items![index].addPrice,
                      ),
                  ),
                  onTap: (bool value, int selectedIndex) =>
                      controller.multiAddFeatureSelection(sectionIndex,value,featureIndex, selectedIndex),
                  maxSection: features.maxCount,
                );
              }
              else return SizedBox();
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: paddingM);
            },
          ),
        ),
      ],
    );
  }
}
*/
