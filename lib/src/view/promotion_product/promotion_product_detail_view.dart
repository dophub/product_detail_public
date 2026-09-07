import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_detail/extension.dart';
import 'package:product_detail/src/app/component/section/single_Section_bottom_sheet.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/i10n/i10n.dart';
import 'package:product_detail/src/controller/promotion_controller.dart';
import 'package:sip_models/response.dart';

import '../../app/component/other/product_note_field.dart';
import 'promotion_feature_and_option.dart';

/// Promosyonlu Ürün detayının View kısmınıdır
class PromotionProductDetailView extends StatelessWidget {
  final PromotionViewController controller;

  const PromotionProductDetailView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return GetBuilder<PromotionController>(
      id: 'promotionDetailModelUpdate',
      builder: (PromotionController controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Section
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.promotionMenuModel.sections!.length,
              itemBuilder: (BuildContext context, int sectionIndex) {
                List<SectionModel>? sections = controller.promotionMenuModel.sections!;
                return Column(
                  children: [
                    SingleSectionBottomSheet(
                      title: sections[sectionIndex].sectionName!,
                      list: sections[sectionIndex].products!,
                      hintText: AppLocalization.getLabels(context).select,
                      selectedIndex: sections[sectionIndex].getIndexForSelectedProduct(),
                      onTap: (int selectedIndex) => controller.sectionBottomSheetOnChange(sectionIndex, selectedIndex),
                      selectedCardColor: colorScheme.secondary,
                      selectedOnCardColor: colorScheme.onSecondary,
                      showErrorOutline: controller.validate &&
                          !sections[sectionIndex].isSelected &&
                          sections[sectionIndex].chooseRequired != false,
                    ),
                    // Section secilmiş mi
                    sections[sectionIndex].isSelected
                        ? Builder(
                            builder: (context) {
                              final selectedProduct = sections[sectionIndex].getSelectedProduct();
                              return PromotionFeatureAndOption(
                                featuresList: selectedProduct?.features ?? [],
                                optionGroupsList: selectedProduct?.optionGroups ?? [],
                                sectionIndex: sectionIndex,
                              );
                            },
                          )
                        : const SizedBox(),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: paddingXS);
              },
            ),

            const SizedBox(height: paddingXS),

            /// Note
            ProductNoteField(
              controller: controller.cNote,
              onClose: controller.onCloseNotDialog,
            ),
          ],
        );
      },
    );
  }
}
