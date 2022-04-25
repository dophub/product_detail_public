import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:product_detail/src/app/component/other/TitleWithRightSubTitleAndMark.dart';
import 'package:product_detail/src/app/const/PaddingAndRadiusSize.dart';
import 'package:product_detail/src/app/const/TSColors.dart';
import 'package:product_detail/src/app/const/TSTextStyle.dart';
import 'package:sip_models/widget.dart';

/// Ürün de olan malzemeleri cıkarmak için olüştürldü
/// Birden fazla seçmeli
/// [title] Başlığın yanında gösterilen alt başlık
/// [list] Malzeme model listesi
/// [onTap] item seçildiğinde oluşan feedback
/// Status = true malzeme üründe olsun
/// Status = false malzeme üründen cıkartıldı
class MultiSectionDecreaseSection extends StatelessWidget {
  final String title;

  final String? subTitle;

  final List<SectionsWidgetModel> list;

  final void Function(SectionsWidgetModel, int) onTap;

  const MultiSectionDecreaseSection({
    Key? key,
    required this.title,
    this.subTitle,
    required this.onTap,
    required this.list,
  }) : super(key: key);

  /// [selected] = true malzeme üründe olsun
  /// [selected] = false malzeme üründen cıkartıldı

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWithRightSubTitleAndMark(
              title: title,
              subTitle: subTitle,
              showMark: list.indexWhere((element) => element.status!) == -1
                  ? false
                  : true,
            ),
            SizedBox(height: paddingM),
            Wrap(
              runSpacing: paddingXS,
              spacing: paddingXS,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: list
                  .mapIndexed(
                    (index, element) => GestureDetector(
                      onTap: () => onSelect(index),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusXXXS),
                            border: Border.all(
                                color: element.status!
                                    ? TSColor.paleTextColor
                                    : TSColor.turkcellBlue, width: 1)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: paddingXS, vertical: paddingXXS),
                          child: Text(
                            element.name,
                            style: s16W400Dark(context).copyWith(
                              color: element.status!
                                  ? TSColor.paleTextColor
                                  : TSColor.darkText,
                                decoration: !element.status!
                                    ? TextDecoration.none
                                    : TextDecoration.lineThrough),
                          ),
                        ),
                      ),
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
    list[index].status = !list[index].status!;
    onTap(list[index], index);
  }
}
