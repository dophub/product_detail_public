import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Widget/Dialog/TSDialog.dart';

class TSSimpleDialog {

  Future show(BuildContext context, {Widget? title,List<Widget>? children, EdgeInsets? padding,bool? barrierDismissible}) {
    return TSDialog().showDynamicDialog(
      context,
      barrierColor: Colors.black45,
      barrierDismissible: barrierDismissible,
      widget: SimpleDialog(
        title: title,
        titlePadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).cardColor,
        contentPadding: padding ?? const EdgeInsets.all(paddingM),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusL)),
        children: children,
      ),
    );
  }
}
