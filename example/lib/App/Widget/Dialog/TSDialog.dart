import 'package:flutter/material.dart';

/// Base Dialog
class TSDialog {
  Future showDynamicDialog(BuildContext context, {required Widget widget,bool? barrierDismissible,Color? barrierColor}) {
    return showDialog(
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: barrierColor,
      context: context,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}
