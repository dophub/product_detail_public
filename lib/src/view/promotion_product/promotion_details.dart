import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_detail/src/app/component/other/note_dialog.dart';
import 'package:product_detail/src/app/component/section/single_Section_bottom_sheet.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_colors.dart';
import 'package:product_detail/src/controller/promotion_controller.dart';
import 'package:sip_models/response.dart';

import 'promotion_feature_and_option.dart';

class PromotionDetails extends StatelessWidget {
  /// Ürün section, Feature ve option lerini listeler

  PromotionDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromotionController>(
        id: 'promotionDetailModelUpdate',
        builder: (PromotionController controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: paddingM)
                        .copyWith(top: paddingM),
                    child: ListView.separated(
                      // Promotion Menü (Section,Option ve Feature)
                      physics: NeverScrollableScrollPhysics(),
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
                              hintText: 'Seçiniz',
                              selectedIndex: controller.getIndexForSelectedProduct(sectionIndex),
                              onTap: (int selectedIndex) => controller.sectionBottomSheetOnChange(sectionIndex, selectedIndex),
                              selectedCardColor: AppColor.turkcellYellow,
                            ),
                            // Section secilmiş mi
                            controller.promotionMenuModel
                                    .sections![sectionIndex].isSelected
                                ? PromotionFeatureAndOption(
                                    featuresList: controller.getFeaturesForSelectedProduct(sectionIndex) ?? [],
                                    optionGroupsList: controller.getOptionsForSelectedProduct(sectionIndex) ?? [],
                                    sectionIndex: sectionIndex,
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: paddingM);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(paddingM),
                    child: GestureDetector(
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
                  ),
                ],
              )
            ],
          );
        });
  }
}