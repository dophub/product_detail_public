import 'package:flutter/material.dart';

/// Bottom Sheetin üst kısmında gösterilen sürekle bırak çizgisi
class BottomSheetHoldAndDragWidget extends StatelessWidget {
  const BottomSheetHoldAndDragWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50.0,
        height: 4.0,
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      ),
    );
  }
}
