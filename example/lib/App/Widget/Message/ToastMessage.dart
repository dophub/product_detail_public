import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/TSTextStyle.dart';

/// [widget] Toast mesaj da gösterilen custom widget eğer null ise default widget gösterilecektir
/// [duration] Toast mesajı SN cinsinden gösterme süresi eğer null ise 3 Sn olarak devam edecek
/// [textMessage] eğer [widget] null olupta bu Text metini default Toast message'nde gösterilecektir
ToastFuture showToastMessage(BuildContext context,
    {Widget? widget, int? duration, String? textMessage}) {
  if (widget == null && textMessage == null)
    throw "Toast Message de widget ve textMassage parametreleri ikisi birden null olamaz.\n"
        "if(widget == null && textMessage == null) Doğru değil.";
  else
    return showToastWidget(
      widget ??
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            margin: EdgeInsets.symmetric(horizontal: 50.0),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radiusXS),
              ),
              color: Colors.black45,
            ),
            child: Text(
              textMessage!,
              style: s16W400Dark(context).copyWith(color: Colors.white),
            ),
          ),
      context: context,
      isIgnoring: false,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      position: StyledToastPosition(align: Alignment.topCenter, offset: 0.0),
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: Duration(seconds: duration ?? 3),
      animDuration: Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn,
    );
}
