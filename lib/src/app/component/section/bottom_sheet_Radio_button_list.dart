import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';
import 'package:sip_models/widget.dart';

import '../other/price_text_widget_with_parentheses.dart';

/// Radio Button Liste
/// [selectedIndex] seçilen index
class BottomSheetRadioButtonList<T extends ISectionsWidgetModel> extends StatefulWidget {
  final Widget? radioButtonWidget;
  final void Function(int) onTap;
  final List<T> list;
  final int? selectedIndex;
  final double? radioButtonSize;

  const BottomSheetRadioButtonList({
    super.key,
    required this.onTap,
    required this.list,
    required this.selectedIndex,
    this.radioButtonSize,
    this.radioButtonWidget,
  });

  @override
  State<BottomSheetRadioButtonList<T>> createState() => _BottomSheetRadioButtonListState<T>();
}

class _BottomSheetRadioButtonListState<T extends ISectionsWidgetModel> extends State<BottomSheetRadioButtonList<T>> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.list.mapIndexed<Widget>(
        (index, element) {
          final Color cardColor;
          final Color onCardColor;
          final Color borderColor;
          final bool showCheckBoxBorder;
          if (selectedIndex == index) {
            cardColor = colorScheme.secondary;
            onCardColor = colorScheme.onSecondary;
            borderColor = colorScheme.secondary;
            showCheckBoxBorder = true;
          } else {
            cardColor = Colors.transparent;
            onCardColor = colorScheme.primary;
            borderColor = colorScheme.primary;
            showCheckBoxBorder = false;
          }
          return InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => onSelect(index),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: paddingXXS),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(radiusXS),
                    border: Border.all(
                      width: 1,
                      color: borderColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(paddingXS),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.radioButtonWidget ??
                            SizedBox(
                              height: widget.radioButtonSize ?? 30,
                              width: widget.radioButtonSize ?? 30,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: onCardColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(paddingXXXXS),
                                  child: Visibility(
                                    visible: showCheckBoxBorder,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: colorScheme.onSecondary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        const SizedBox(width: paddingXS),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: PriceTextWidgetWithParentheses(
                              price: widget.list[index].getPrice,
                              name: widget.list[index].getName,
                              textStyle: s16W600Dark(context),
                              color: onCardColor,
                              priceColor: onCardColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Future<void> onSelect(int? index) async {
    if (index != null) {
      selectedIndex = index;
      setState(() {});
      widget.onTap(index);
    }
  }
}
