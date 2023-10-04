import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:product_detail/src/app/component/other/title_with_right_sub_title_and_mark.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_colors.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';
import 'package:sip_models/widget.dart';

/// Ürün de olan malzemeleri cıkarmak için olüştürldü
/// Birden fazla seçmeli
/// [title] Başlığın yanında gösterilen alt başlık
/// [list] Malzeme model listesi
/// [onTap] item seçildiğinde oluşan feedback
/// Status = true malzeme üründe olsun
/// Status = false malzeme üründen cıkartıldı
class MultiSectionDecreaseSection<T extends ISectionsWidgetModel> extends StatelessWidget {
  final String title;

  final String? subTitle;

  final List<T> list;

  final void Function(T, int) onTap;

  final bool showErrorOutline;

  const MultiSectionDecreaseSection({
    Key? key,
    required this.title,
    this.subTitle,
    required this.onTap,
    required this.list,
    required this.showErrorOutline,
  }) : super(key: key);

  /// [selected] = true malzeme üründen cıkartıldı
  /// [selected] = false malzeme üründe olsun

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: showErrorOutline
          ? RoundedRectangleBorder(
              side: BorderSide(color: AppColor.cardOutlineErrorColor, width: 1),
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
            ),
            const SizedBox(height: paddingM),
            Wrap(
              runSpacing: paddingXS,
              spacing: paddingXS,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: list
                  .mapIndexed(
                    (index, element) => Builder(
                      builder: (context) {
                        Color color;
                        TextDecoration titleTextDecoration;
                        if (element.getStatus == false) {
                          color = Theme.of(context).colorScheme.primary;
                          titleTextDecoration = TextDecoration.none;
                        } else {
                          color = AppColor.darkText;
                          titleTextDecoration = TextDecoration.lineThrough;
                        }
                        return GestureDetector(
                          onTap: () => onSelect(index),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXXXS),
                              border: Border.all(
                                color: color,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: paddingXS, vertical: paddingXXS),
                              child: Text(
                                element.getName,
                                style: s16W400Dark(context).copyWith(
                                  color: color,
                                  decoration: titleTextDecoration,
                                ),
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

  void onSelect(int index) {
    /// Seçili item var mı diye kontrol ediyoruz
    /// Eğer Varsa Başlık satırında Sarı işaret bırakıyoruz
    list[index].setStatus = !list[index].getStatus;
    onTap(list[index], index);
  }
}
