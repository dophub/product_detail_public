import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_detail/src/app/const/assets.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';
import 'package:sip_models/widget.dart';
import '../../i10n/i10n.dart';
import '../other/bottom_sheet_hold_and_drag_widget.dart';
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
  final Color? selectedOnCardColor;
  final bool showErrorOutline;

  const SingleSectionBottomSheet({
    super.key,
    required this.title,
    this.subTitle,
    required this.list,
    required this.onTap,
    this.selectedIndex,
    this.hintText,
    this.selectedCardColor,
    this.selectedOnCardColor,
    required this.showErrorOutline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color cardColor = theme.cardColor;
    Color onCardColor = theme.colorScheme.onBackground;
    if (selectedIndex != null) {
      if (selectedCardColor != null) cardColor = selectedCardColor!;
      if (selectedOnCardColor != null) onCardColor = selectedOnCardColor!;
    }
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => onSelect(context),
      child: Card(
        color: cardColor,
        shape: showErrorOutline
            ? RoundedRectangleBorder(
                side: BorderSide(color: theme.colorScheme.errorContainer, width: 1),
                borderRadius: BorderRadius.circular(radiusXS),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingM, vertical: paddingS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: paddingXXXS),
                child: Text(
                  title,
                  style: s13W400Dark(context).copyWith(color: onCardColor),
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
                              AppLocalization.getLabels(context).select,
                              softWrap: true,
                              style: s13W600Dark(context).copyWith(color: onCardColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textWidthBasis: TextWidthBasis.longestLine,
                            )
                          : PriceTextWidgetWithParentheses(
                              price: list[selectedIndex!].getPrice,
                              name: list[selectedIndex!].getName,
                              maxLines: 1,
                              color: onCardColor,
                              priceColor: onCardColor,
                            ),
                    ),
                    const SizedBox(width: paddingXXXS),
                    SvgPicture.asset(
                      arrowIcon,
                      height: 6,
                      package: 'product_detail',
                      color: onCardColor,
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
    final screenSize = MediaQuery.of(context).size;

    final w = LayoutBuilder(builder: (BuildContext context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: paddingL,
          vertical: paddingM,
        ).copyWith(top: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: s16W600Dark(context),
                  ),
                  subTitle != null && subTitle!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: paddingXXXXXS),
                          child: Text(
                            subTitle!,
                            style: s14W400Dark(context),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: paddingXXXS),
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
      );
    });

    if (screenSize.width < 600) {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusXL),
          ),
        ),
        backgroundColor: CardTheme.of(context).color,
        builder: (BuildContext context) {
          return SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenSize.width, maxHeight: screenSize.height / 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: paddingM),
                  const BottomSheetHoldAndDragWidget(),
                  const SizedBox(height: paddingM),
                  Flexible(child: w),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).orientation == Orientation.portrait
                    ? screenSize.width
                    : screenSize.width / 2,
                maxHeight: MediaQuery.of(context).orientation == Orientation.portrait
                    ? screenSize.width
                    : screenSize.width / 2,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: paddingM),
                child: w,
              ),
            ),
          );
        },
      );
    }
  }
}
