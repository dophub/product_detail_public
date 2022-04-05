import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/TSColors.dart';
import 'package:example/Screen/ProductProfileScreen/product_profile_screen.dart';

/// [ProductProfileScreen] de Ürün resmin alt kısmında gösterilen resim index ini beliten teg Listesin.
/// [width] Genişlik.
/// [length] Resim adedi gelen model uzunluğu.
/// [selectedIndex] O anki bulundğumuz resim index idir.
///
class ImageListPositionsTag extends StatelessWidget {
  const ImageListPositionsTag({
    Key? key,
    required this.length,
    required this.selectedIndex, this.color
  }) : super(key: key);

  final double width = 10;
  final int length;
  final int selectedIndex;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // radiusL yi eklememizin sebebi bottom sheetin yan taraflarının radius i olmasından dolayı
        height: width,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: length == 1 ? 0 : length,
          itemBuilder: (BuildContext context, int index) {
            return  selectedIndex == index
                ? Container(
                width: width * 3,
                decoration: BoxDecoration(
                  color: color ?? AppColor.primaryVariant,
                  borderRadius: BorderRadius.circular(radiusXXXL),
                ),
              ): Container(
                width: width,
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.circular(radiusXXXL),
                ),
              );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 5,
            );
          },
        ),
      ),
    );
  }
}
