import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Button/CircleAddButton.dart';
import 'package:example/App/Widget/Button/CircleDecreaseButton.dart';

/// Ürün Miktar butonu ' - Aded + ' Şeklinde
class QuantityButton extends StatelessWidget {
  final ValueChanged<int> onChange;
  final int quantity;
  final bool deleteAble;
  final double? iconSize;

  QuantityButton({
    Key? key,
    required this.onChange,
    this.deleteAble = false,
    this.quantity = 1,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleDecreaseButton(
          deleteAble: deleteAble,
          quantity: quantity,
          onTap: () {
            if (quantity > 1)
              onChange(quantity - 1);
            else {
              if(deleteAble) onChange(0);
            }
          },
          iconSize: iconSize,
        ),
        Container(
          alignment: Alignment.center,
          width: SizeConfig.blockSizeHorizontal * 6,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(quantity.toString(),
                style: s16W700Dark(context), maxLines: 1),
          ),
        ),
        CircleAddButton(
          iconSize: iconSize,
          onTap: () => onChange(quantity + 1),
        )
      ],
    );
  }
}
