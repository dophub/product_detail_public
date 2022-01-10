import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_detail/src/app/component/other/NoteDialog.dart';
import 'package:product_detail/src/app/component/section/MultiSectionCheckBox.dart';
import 'package:product_detail/src/app/component/section/ProductDecriseSection.dart';
import 'package:product_detail/src/app/component/section/SingleSectionBottomSheet.dart';
import 'package:product_detail/src/app/component/section/SingleSectionRadioButton.dart';
import 'package:product_detail/src/app/const/PaddingAndRadiusSize.dart';
import 'package:product_detail/src/controller/ProductController.dart';
import 'package:sip_models/sip_enum.dart';
import 'package:sip_models/sip_general_models.dart';

/// Product optionGroups
class FeatureAndOption extends StatelessWidget {

  const FeatureAndOption({
    Key? key,
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
                padding: EdgeInsets.only(bottom: controller.productDetailModel.optionGroups!.length == 0 ? 0 :paddingM),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.productDetailModel.optionGroups!.length,
                  itemBuilder: (BuildContext context, int optionGroupsIndex) {
                    var optionGroup = controller.productDetailModel.optionGroups![optionGroupsIndex];
                    if (optionGroup.addingTypeId == describeEnum(AddingTypeId.SELECT) && optionGroup.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                      /// Tekli Seçim
                      return SingleSectionRadioButton(
                        title: optionGroup.optionGroupName!,
                        subTitle: optionGroup.description,
                        selectedIndex: controller.getIndexForSelectedOption(optionGroupsIndex),
                        onTap: (int selectedIndex) => controller.singleOptionSelection( optionGroupsIndex, selectedIndex),
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
                        onTap: (SectionsWidgetModel obj, int selectedIndex) => controller.multiDecreaseOptionSelection(obj.status!,optionGroupsIndex, selectedIndex),
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
                        selectedIndex: controller.getIndexForSelectedOption(optionGroupsIndex),
                        onTap: (int selectedIndex) => controller.singleOptionSelection(optionGroupsIndex, selectedIndex),
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
                        onTap: (bool value, int selectedIndex) => controller.multiAddOptionSelection(value,optionGroupsIndex, selectedIndex),
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
              /// Product Features
              Padding(
                padding: EdgeInsets.only(bottom:  controller.productDetailModel.features!.length == 0 ? 0 :paddingM),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.productDetailModel.features!.length,
                  itemBuilder: (BuildContext context, int featureIndex) {
                    var features = controller.productDetailModel.features![featureIndex];
                    if (features.addingTypeId == describeEnum(AddingTypeId.SELECT) && features.chooseTypeId == describeEnum(ChooseTypeId.SINGLE)) {
                      /// Tekli Seçme
                      return SingleSectionRadioButton(
                        title: features.featureName!,
                        subTitle: features.description,
                        selectedIndex: controller.getIndexForSelectedFeatureItem(featureIndex),
                        onTap: (int selectedIndex) => controller.singleFeatureSelection(featureIndex, selectedIndex),
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
                         onTap: (SectionsWidgetModel obj, int selectedIndex) => controller.multiDecreaseFeatureSelection(obj.status!,featureIndex, selectedIndex),
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
                        selectedIndex: controller.getIndexForSelectedFeatureItem(featureIndex),
                        onTap: (int selectedIndex) => controller.singleFeatureSelection(featureIndex, selectedIndex),
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
                            controller.multiAddFeatureSelection(value,featureIndex, selectedIndex),
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
              GestureDetector(
                child: GestureDetector(
                  onTap: (){
                    NoteDialog().showMenuDialog(
                      context,
                      text: controller.cNote.text,
                      onClose: controller.onCloseNotDialog,
                    );},
                  child: TextFormField(
                    controller: controller.cNote,
                    decoration: InputDecoration(
                        hintText: 'Ürün Notu',
                        fillColor: Theme.of(context).colorScheme.background),
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
         }
       );
  }
}
