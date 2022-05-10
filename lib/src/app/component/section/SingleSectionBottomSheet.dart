import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_detail/src/app/const/Assets.dart';
import 'package:product_detail/src/app/const/PaddingAndRadiusSize.dart';
import 'package:product_detail/src/app/const/TSTextStyle.dart';
import 'package:sip_models/widget.dart';
import '../other/BottomSheetHoldAndDragWidget.dart';
import 'BottomSheetRadioButtonList.dart';

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

  const SingleSectionBottomSheet({
    Key? key,
    required this.title,
    this.subTitle,
    required this.list,
    required this.onTap,
    this.selectedIndex,
    this.hintText,
    this.selectedCardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(context),
      child: Card(
        color: selectedIndex != null ? selectedCardColor ?? Theme.of(context).cardColor :  Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(paddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: s16W400Dark(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        selectedIndex == null
                            ? 'Seçiniz'
                            : list[selectedIndex!].getName,
                        softWrap: true,
                        style: s16W700Dark(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                    ),
                    SizedBox(
                      width: paddingXXS,
                    ),
                    SvgPicture.asset(
                      arrowIcon,
                      height: 6,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusXL),
        ),
      ),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
      backgroundColor: Theme.of(context).cardTheme.color,
      builder: (BuildContext context) {
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingL,vertical: paddingM),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHoldAndDragWidget(),
              SizedBox(height: paddingM),
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
                    subTitle != null && subTitle!.isNotEmpty?
                   Padding(
                     padding: const EdgeInsets.only(top: paddingXS),
                     child: Text(
                              subTitle!,
                              style: s14W400Dark(context),
                            ),
                   )
                   : SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: paddingM),
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
