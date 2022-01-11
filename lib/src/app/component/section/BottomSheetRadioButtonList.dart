import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:product_detail/src/app/const/PaddingAndRadiusSize.dart';
import 'package:product_detail/src/app/const/TSColors.dart';
import 'package:product_detail/src/app/const/TSTextStyle.dart';
import 'package:sip_models/widget.dart';

import '../other/PriceTextWidgetWithParentheses.dart';

/// Radio Button Liste
/// [selectedIndex] seçilen index
class BottomSheetRadioButtonList extends StatelessWidget {
  final Widget? radioButtonWidget;

  const BottomSheetRadioButtonList(
      {Key? key,
      required this.onTap,
      required this.list,
      required this.selectedIndex,
      this.radioButtonSize,
      this.radioButtonWidget})
      : super(key: key);
  final void Function(int) onTap;
  final List<SectionsWidgetModel> list;
  final int? selectedIndex;
  final double? radioButtonSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list
          .mapIndexed<Widget>((index, element) => GestureDetector(
                onTap: () => onSelect(index),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: paddingXS),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? TSColor.turkcellYellow
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusXS),
                          border: selectedIndex == index
                              ? null
                              : Border.all(
                                  width: 1, color: TSColor.turkcellBlue)),
                      child: Padding(
                        padding: const EdgeInsets.all(paddingS),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            radioButtonWidget ??
                                Container(
                                  height: radioButtonSize ?? 30,
                                  width: radioButtonSize ?? 30,
                                  padding: EdgeInsets.all(paddingXXXS),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: selectedIndex == index
                                          ? TSColor.darkText
                                          : TSColor.turkcellBlue,
                                    ),
                                  ),
                                  child: Visibility(
                                    visible: selectedIndex == index,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: TSColor.darkText,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                            SizedBox(width: paddingS),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(left: paddingXS),
                                child: PriceTextWidgetWithParentheses(
                                  price: list[index].price,
                                  name: list[index].name,
                                  textStyle: s16W700Dark(context),
                                  color: selectedIndex == index
                                      ? TSColor.darkText
                                      : TSColor.turkcellBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Future<void> onSelect(int? index) async {
    if (index != null) {
      onTap(index);
    }
  }
}
