import 'package:flutter/material.dart';
import 'package:example/App/Widget/Dialog/TSDialog.dart';

class LoadingProgress {
  LoadingProgress.showLoading(BuildContext context) {
    TSDialog().showDynamicDialog(
      context,
      barrierColor: Colors.black38,
      barrierDismissible: true,
      widget: FittedBox(
        fit: BoxFit.scaleDown,
        child: CircularProgressIndicator(strokeWidth: 3,),
      ),
    );
  }

  LoadingProgress.done(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
