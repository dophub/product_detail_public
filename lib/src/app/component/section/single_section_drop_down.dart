import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';
import 'package:collection/collection.dart';
import 'package:sip_models/widget.dart';

import '../other/price_text_widget_with_parentheses.dart';

/// Tekli seçmelide kullanılan dropdown
/// [title] dropdown üst kısmında cıkan başlık
/// [subTitle] dropdown üst kısmında cıkan [title] ın sağ tarafında cıkan altBaşlık
/// [list] dropdown tarafından listelenecek özelik listemiz
/// [onTap] dropdown de item seçildiğinde oluşan feedback
/// [selectedIndex] dropdown init olduğunda hangi item index'i seçili olaçak
/// [hintText] dropdown init olduğunda ve [selectedIndex] null olduğunda dropdown'de gösterilen metin
/// [hintText] ve [selectedIndex] null olduğunda [selectedIndex] imiz [initState] te 0 'a eşitlenecek
class SingleSectionDropDown<T extends ISectionsWidgetModel> extends StatelessWidget {
  final List<T>? list;
  final void Function(int) onTap;
  final int? selectedIndex;
  final String? hintText;

  const SingleSectionDropDown({
    Key? key,
    required this.list,
    required this.onTap,
    this.selectedIndex = 0,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingM),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedIndex,
                hint: hintText == null ? null : Text(hintText!, style: s16W400Dark(context)),
                isExpanded: true,
                icon: const Icon(
                  CupertinoIcons.chevron_down,
                  size: 18,
                ),
                iconSize: 24,
                elevation: 2,
                dropdownColor: Theme.of(context).cardTheme.color,
                style: s16W400Dark(context),
                onChanged: onSelect,
                items: list!
                    .mapIndexed<DropdownMenuItem<int>>(
                      (index, element) => DropdownMenuItem(
                        value: index,
                        child: PriceTextWidgetWithParentheses(
                          price: element.getPrice,
                          name: element.getName,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onSelect(int? selectedIndex) {
    if (selectedIndex != null) {
      onTap(selectedIndex);
    }
  }
}