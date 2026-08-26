import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:product_detail/src/app/component/other/title_with_right_sub_title_and_mark.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';
import 'package:sip_models/widget.dart';

/// Birden falza seçmelide kullanılan card list
/// [title] checkBox üst kısmında cıkan başlık
/// [subTitle] dropdown üst kısmında cıkan [title] ın sağ tarafında cıkan altBaşlık
/// [list] checkBoxListTile tarafından listelenecek özelik listemiz
/// [onTap] checkBox de item seçildiğinde oluşan feedback
/// [maxSection] checkBoxList te max seçilebilecek item sayı
class MultiSectionCard<T extends ISectionsWidgetModel> extends StatelessWidget {
  final String title;
  final String? subTitle;
  final List<T> list;
  final void Function(bool, int) onTap;
  final int? maxSection;
  final bool showErrorOutline;

  const MultiSectionCard({
    super.key,
    required this.title,
    this.subTitle,
    required this.list,
    required this.onTap,
    this.maxSection,
    required this.showErrorOutline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.cardColor,
      shape: showErrorOutline
          ? RoundedRectangleBorder(
              side: BorderSide(color: theme.colorScheme.errorContainer, width: 1),
              borderRadius: BorderRadius.circular(radiusXS),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWithRightSubTitleAndMark(
              title: title,
              subTitle: subTitle,
              maxCount: maxSection,
            ),
            const SizedBox(height: paddingS),
            Wrap(
              runSpacing: paddingXXS,
              spacing: paddingXXS,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: list
                  .mapIndexed(
                    (index, element) => Builder(
                      builder: (context) {
                        Color cardColor;
                        Color borderColor;
                        Color? textColor;
                        if (element.getStatus == true) {
                          cardColor = theme.colorScheme.secondary;
                          borderColor = theme.colorScheme.secondary;
                          textColor = theme.colorScheme.onSecondary;
                        } else {
                          cardColor = Colors.transparent;
                          borderColor = theme.colorScheme.onBackground;
                          textColor = null;
                        }
                        return InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => onSelect(context, !element.getStatus, index),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(radiusXXXS),
                              border: Border.all(color: borderColor, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: paddingXXS, vertical: paddingXXXS),
                              child: Text(
                                element.getName,
                                style: s12W400Dark(context).copyWith(color: textColor),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void onSelect(BuildContext context, bool? value, int index) {
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
