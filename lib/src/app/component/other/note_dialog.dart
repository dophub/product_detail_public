import 'package:flutter/material.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';

import 'app_button.dart';
import 'app_dialog.dart';

/// Note TextFilede tıklandığında çıkan Note Dialoğu
class NoteDialog {
  final _cNote = TextEditingController();

  Future showMenuDialog(
    BuildContext context, {
    String text = '',
    required Function(String) onClose,
  }) {
    return AppDialog().showDynamicDialog(
      context,
      barrierColor: Colors.black45,
      widget: Theme(
        data: Theme.of(context).copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: s14W400Dark(context).fontSize,
                  fontWeight: s14W400Dark(context).fontWeight,
                ),
              ),
            ),
          ),
        ),
        child: SimpleDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusXS)),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: paddingM),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: paddingM),
                      TextFormField(
                        controller: _cNote,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Ürün Notu',
                          fillColor: Theme.of(context).colorScheme.background,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        // validator: (str) => str!.trim().isName(),
                        onFieldSubmitted: (_) {
                          onClose(_cNote.text.trim());
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                padding: EdgeInsets.zero,
                                buttonPadding: EdgeInsets.zero,
                                onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                                txt: 'Kapat',
                              ),
                            ),
                            const SizedBox(width: paddingM),
                            Expanded(
                              child: AppButton(
                                padding: EdgeInsets.zero,
                                buttonPadding: EdgeInsets.zero,
                                onTap: () {
                                  onClose(_cNote.text.trim());
                                  Navigator.of(context, rootNavigator: true).pop();
                                },
                                txt: 'Not Ekle',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: paddingS),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
