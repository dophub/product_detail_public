import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:product_detail/src/app/component/other/title_with_right_sub_title_and_mark.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:sip_models/widget.dart';
import '../../const/app_colors.dart';
import '../other/price_text_widget_with_parentheses.dart';

/// Birden falza seçmelide kullanılan checkBox list
/// [title] checkBox üst kısmında cıkan başlık
/// [subTitle] dropdown üst kısmında cıkan [title] ın sağ tarafında cıkan altBaşlık
/// [list] checkBoxListTile tarafından listelenecek özelik listemiz
/// [onTap] checkBox de item seçildiğinde oluşan feedback
/// [maxSection] checkBoxList te max seçilebilecek item sayısı
class MultiSectionCheckBox<T extends ISectionsWidgetModel> extends StatelessWidget {
  final String title;
  final String? subTitle;
  final List<T> list;
  final void Function(bool, int) onTap;
  final int? maxSection;
  final bool showErrorOutline;

  const MultiSectionCheckBox({
    Key? key,
    required this.title,
    this.subTitle,
    required this.list,
    required this.onTap,
    this.maxSection,
    required this.showErrorOutline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: showErrorOutline
          ? RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.errorContainer,width: 1),
              borderRadius: BorderRadius.circular(radiusXS),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(paddingM).copyWith(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWithRightSubTitleAndMark(
              title: title,
              subTitle: subTitle,
              maxCount: maxSection,
            ),
            SizedBox(height: paddingM),
            Column(
              children: list
                  .mapIndexed<Widget>((index, element) => GestureDetector(
                        onTap: () => onSelect(context,!list[index].getStatus, index),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Checkbox(
                                side: Theme.of(context).checkboxTheme.side!.copyWith(width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(radiusXXXXXS),
                                ),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: list[index].getStatus,
                                onChanged: (value) => onSelect(context,value, index),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(left: paddingXS, bottom: paddingM),
                                child: PriceTextWidgetWithParentheses(
                                    price: list[index].getPrice, name: list[index].getName),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  void onSelect(BuildContext context,bool? value, int index) {
    if (value != null) {
      /// Eğer Max seçim girilmemiş ise
      if (maxSection == null || maxSection == 0 || !value) {
        select(value, index);
      } else {
        /// Kaç seçim seçilmiş diye hesaplıyoruz
        int count = 0;
        for (var loopValue in list) {
          if (loopValue.getStatus) {
            count++;
          }
        }

        /// Eğer seçilen seçim adedi max seçimden küçük ise
        if (count < maxSection!) {
          select(value, index);
        } else {
          /// Eğer büyük ise kullanıcın seçmesine izin vermiyoruz
          debugPrint('En fazla $maxSection seçim yapabilirsiniz.');
        }
      }
    }
  }

  void select(bool value, int index) {
    /// Seçilen seçimi fonksiyon ile feedback yapıyoruz
    debugPrint(list[index].getName);
    onTap(value, index);
  }
}
