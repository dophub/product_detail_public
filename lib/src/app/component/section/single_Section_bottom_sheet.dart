import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_detail/src/app/const/assets.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';
import 'package:sip_models/widget.dart';
import '../other/bottom_sheet_hold_and_drag_widget.dart';
import '../../../app/const/app_colors.dart';
import '../other/price_text_widget_with_parentheses.dart';
import 'bottom_sheet_Radio_button_list.dart';

/// Tekli seçmelide kullanılan dropdown
/// [title] dropdown üst kısmında cıkan başlık
/// [subTitle] dropdown üst kısmında cıkan [title] ın sağ tarafında cıkan altBaşlık
/// [list] dropdown tarafından listelenecek özelik listemiz
/// [onTap] dropdown de item seçildiğinde oluşan feedback
/// [selectedIndex] dropdown init olduğunda hangi item index'i seçili olaçak
/// [hintText] dropdown init olduğunda ve [selectedIndex] null olduğunda dropdown'de gösterilen metin
/// [hintText] ve [selectedIndex] null olduğunda [selectedIndex] imiz [initState] te 0 'a eşitlenecek
/// [selectedCardColor] Item seçildiğinde card rengi verilen renge değişecek
class SingleSectionBottomSheet<T extends ISectionsWidgetModel> extends StatelessWidget {
  final String title;
  final String? subTitle;
  final List<T> list;
  final void Function(int) onTap;
  final int? selectedIndex;
  final String? hintText;
  final Color? selectedCardColor;
  final bool showErrorOutline;

  const SingleSectionBottomSheet({
    Key? key,
    required this.title,
    this.subTitle,
    required this.list,
    required this.onTap,
    this.selectedIndex,
    this.hintText,
    this.selectedCardColor,
    required this.showErrorOutline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(context),
      child: Card(
        color: selectedIndex != null ? selectedCardColor ?? Theme.of(context).cardColor : Theme.of(context).cardColor,
        shape: showErrorOutline
            ? RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.errorContainer, width: 1),
                borderRadius: BorderRadius.circular(radiusXS),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(paddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: paddingXXS),
                child: Text(
                  title,
                  style: s16W400Dark(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: selectedIndex == null
                          ? Text(
                              'Seçiniz',
                              softWrap: true,
                              style: s16W700Dark(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textWidthBasis: TextWidthBasis.longestLine,
                            )
                          : PriceTextWidgetWithParentheses(
                              price: list[selectedIndex!].getPrice,
                              name: list[selectedIndex!].getName,
                              maxLines: 1,
                            ),
                    ),
                    const SizedBox(width: paddingXXS),
                    SvgPicture.asset(
                      arrowIcon,
                      height: 6,
                      package: 'product_detail',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onSelect(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusXL),
        ),
      ),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
      backgroundColor: Theme.of(context).cardTheme.color,
      builder: (BuildContext context) {
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingL, vertical: paddingM),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetHoldAndDragWidget(),
              const SizedBox(height: paddingM),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: s18W700Dark(context),
                    ),
                    subTitle != null && subTitle!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: paddingXS),
                            child: Text(
                              subTitle!,
                              style: s14W400Dark(context),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(height: paddingM),
              Flexible(
                child: SingleChildScrollView(
                  child: BottomSheetRadioButtonList(
                    selectedIndex: selectedIndex,
                    list: list,
                    onTap: (int index) {
                      onTap(index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
