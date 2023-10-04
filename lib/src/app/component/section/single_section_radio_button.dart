import 'package:flutter/material.dart';
import 'package:product_detail/src/app/component/other/title_with_right_sub_title_and_mark.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:sip_models/widget.dart';
import '../../const/app_colors.dart';
import 'radio_button_list.dart';

/// Tek seçmelide kullanılan RadioButtonList
/// [title] üst kısımda cıkan başlık
/// [subTitle] üst kısımda cıkan [title] ın sağ tarafında cıkan altBaşlık
/// [list] RadioButonListTile tarafından listelenecek özellik listemiz
/// [onTap] RadioButton de item seçildiğinde oluşan feedback
/// [selectedIndex] RadioButton init olduğunda hangi item index'i seçili olaçak
class SingleSectionRadioButton<T extends ISectionsWidgetModel> extends StatelessWidget {
  final String title;
  final String? subTitle;
  final int? selectedIndex;
  final List<T> list;
  final void Function(int) onTap;
  final bool showErrorOutline;

  const SingleSectionRadioButton({
    Key? key,
    required this.title,
    this.subTitle,
    required this.list,
    required this.onTap,
    required this.selectedIndex,
    required this.showErrorOutline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: showErrorOutline
          ? RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.errorContainer, width: 1),
              borderRadius: BorderRadius.circular(radiusXS),
            )
          : null,
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
            ),
            const SizedBox(height: paddingM),
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
