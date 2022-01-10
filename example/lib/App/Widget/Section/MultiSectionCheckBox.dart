import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Widget/OtherWidgets/PriceTextWidgetWithParentheses.dart';
import 'package:example/App/Widget/title/TitleWithRightSubTitleAndMark.dart';
import 'package:sip_models/sip_general_models.dart';

/// Birden falza seçmelide kullanılan checkBox list
/// [title] checkBox üst kısmında cıkan başlık
/// [subTitle] dropdown üst kısmında cıkan [title] ın sağ tarafında cıkan altBaşlık
/// [list] checkBoxListTile tarafından listelenecek özelik listemiz
/// [onTap] checkBox de item seçildiğinde oluşan feedback
/// [maxSection] checkBoxList te max seçilebilecek item sayısı
class MultiSectionCheckBox extends StatelessWidget {
  final String title;
  final String? subTitle;
  final List<SectionsWidgetModel> list;
  final void Function(bool, int) onTap;
  final int? maxSection;

  const MultiSectionCheckBox({
    Key? key,
    required this.title,
    this.subTitle,
    required this.list,
    required this.onTap,
    this.maxSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(paddingM).copyWith(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWithRightSubTitleAndMark(
              title: title,
              subTitle: subTitle,
              maxCount: maxSection,
              showMark: list.indexWhere((element) => element.status!) == -1
                  ? false
                  : true,
            ),
            SizedBox(height: paddingM),
            Column(
              children: list
                  .mapIndexed<Widget>((index, element) => GestureDetector(
                        onTap: () => onSelect(!list[index].status!, index),
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
                                value: list[index].status,
                                onChanged: (value) => onSelect(value, index),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: paddingXS, bottom: paddingM),
                                child: PriceTextWidgetWithParentheses(price: list[index].price, name: list[index].name),
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

  void onSelect(bool? value, int index) {
    if (value != null) {
      /// Eğer Max seçim girilmemiş ise
      if (maxSection == null ||maxSection == 0 || !value) {
        select(value, index);
      } else {
        /// Kaç seçim seçilmiş diye hesaplıyoruz
        int count = 0;
        for (var loopValue in list) {
          if (loopValue.status!) {
            count++;
          }
        }

        /// Eğer seçilen seçim adedi max seçimden küçük ise
        if (count < maxSection!) {
          select(value, index);
        } else {
          /// Eğer büyük ise kullanıcın seçmesine izin vermiyoruz
          print('Max Seçim aşıldı');
        }
      }
    }
  }

  void select(bool value, int index) {
    /// Seçilen seçimi fonksiyon ile feedback yapıyoruz
    print(list[index].name);
    onTap(value, index);
  }
}
