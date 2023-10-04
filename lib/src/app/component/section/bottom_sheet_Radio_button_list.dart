import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_colors.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';
import 'package:sip_models/widget.dart';

import '../other/price_text_widget_with_parentheses.dart';

/// Radio Button Liste
/// [selectedIndex] seçilen index
class BottomSheetRadioButtonList<T extends ISectionsWidgetModel> extends StatelessWidget {
  final Widget? radioButtonWidget;
  final void Function(int) onTap;
  final List<T> list;
  final int? selectedIndex;
  final double? radioButtonSize;

  const BottomSheetRadioButtonList({
    Key? key,
    required this.onTap,
    required this.list,
    required this.selectedIndex,
    this.radioButtonSize,
    this.radioButtonWidget,
  }) : super(key: key);

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
                        color: selectedIndex == index ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXS),
                        border: selectedIndex == index
                            ? null
                            : Border.all(
                                width: 1,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(paddingS),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            radioButtonWidget ??
                                Container(
                                  height: radioButtonSize ?? 30,
                                  width: radioButtonSize ?? 30,
                                  padding: const EdgeInsets.all(paddingXXXS),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: selectedIndex == index
                                          ? AppColor.darkText
                                          : Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  child: Visibility(
                                    visible: selectedIndex == index,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppColor.darkText,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                            const SizedBox(width: paddingS),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: paddingXS),
                                child: PriceTextWidgetWithParentheses(
                                  price: list[index].getPrice,
                                  name: list[index].getName,
                                  textStyle: s16W700Dark(context),
                                  color: selectedIndex == index
                                      ? AppColor.darkText
                                      : Theme.of(context).colorScheme.primary,
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
