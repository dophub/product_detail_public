import 'package:flutter/material.dart';
import 'package:product_detail/src/app/component/other/TitleWithRightSubTitleAndMark.dart';
import 'package:product_detail/src/app/const/PaddingAndRadiusSize.dart';
import 'package:sip_models/widget.dart';
import 'RadioButtonList.dart';

/// Tek seçmelide kullanılan RadioButtonList
/// [title] üst kısımda cıkan başlık
/// [subTitle] üst kısımda cıkan [title] ın sağ tarafında cıkan altBaşlık
/// [list] RadioButonListTile tarafından listelenecek özellik listemiz
/// [onTap] RadioButton de item seçildiğinde oluşan feedback
/// [selectedIndex] RadioButton init olduğunda hangi item index'i seçili olaçak
class SingleSectionRadioButton extends StatelessWidget {
  final String title;
  final String? subTitle;
  final int? selectedIndex;
  final List<SectionsWidgetModel> list;
  final void Function(int) onTap;

  const SingleSectionRadioButton({
    Key? key,
    required this.title,
    this.subTitle,
    required this.list,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(paddingM).copyWith(bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWithRightSubTitleAndMark(
              title: title,
              subTitle: subTitle,
              showMark: selectedIndex == null ? false : true,
            ),
            SizedBox(height: paddingM),
            Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: RadioButtonList(
                  selectedIndex: selectedIndex,
                  list: list,
                  onTap: onTap,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSelect(int? index) {
    if (index != null) {
      onTap(index);
    }
  }
}

