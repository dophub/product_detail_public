import 'package:flutter/material.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:collection/collection.dart';
import 'package:sip_models/widget.dart';

import '../other/price_text_widget_with_parentheses.dart';

/// Radio Button Liste
/// [selectedIndex] seçilen index
class RadioButtonList<T extends ISectionsWidgetModel> extends StatelessWidget {
  const RadioButtonList({Key? key, required this.onTap, required this.list, required this.selectedIndex})
      : super(key: key);
  final void Function(int) onTap;
  final List<T> list;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list
          .mapIndexed<Widget>((index, element) => GestureDetector(
                onTap: () => onSelect(index),
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Radio(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          value: index,
                          groupValue: selectedIndex,
                          onChanged: onSelect,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: paddingXS, bottom: paddingM),
                          child: PriceTextWidgetWithParentheses(
                            price: list[index].getPrice,
                            name: list[index].getName,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  void onSelect(int? index) {
    if (index != null) {
      onTap(index);
    }
  }
}
