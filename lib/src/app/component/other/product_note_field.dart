import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_detail/src/app/component/other/note_dialog.dart';
import 'package:product_detail/src/app/i10n/i10n.dart';

class ProductNoteField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onClose;

  const ProductNoteField({
    super.key,
    required this.controller,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return GestureDetector(
      onTap: kIsWeb
          ? null
          : () {
              NoteDialog().showMenuDialog(
                context,
                text: controller.text,
                onClose: onClose,
              );
            },
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: AppLocalization.getLabels(context).productNote,
          fillColor: colorScheme.background,
        ),
        textCapitalization: TextCapitalization.sentences,
        maxLines: 3,
        enabled: kIsWeb,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
