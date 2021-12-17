import 'package:flutter/material.dart';
import 'package:product_detail/src/app/const/PaddingAndRadiusSize.dart';
import 'package:product_detail/src/app/const/TSTextStyle.dart';

import 'TSButton.dart';
import 'TSDialog.dart';

/// Note TextFilede tıklandığında çıkan Note Dialoğu
class NoteDialog {
  final TextEditingController _cNote = TextEditingController();

  Future showMenuDialog(BuildContext context,
      {String text = '', required Function(String) onClose}) {
    _cNote.text = text;
    return TSDialog().showDynamicDialog(
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusXS)),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingM),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: paddingM),
                      TextFormField(
                        controller: _cNote,
                        decoration: InputDecoration(
                            hintText: 'Ürün Notu',
                            fillColor:
                                Theme.of(context).colorScheme.background),
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        // validator: (str) => str!.trim().isName(),
                        onFieldSubmitted: (_) {
                          onClose(_cNote.text.trim());
                          Navigator.of(context,rootNavigator: true).pop();
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: TSButton(
                                padding: EdgeInsets.zero,
                                buttonPadding: EdgeInsets.zero,
                                onTap: () => Navigator.of(context,rootNavigator: true).pop(),
                                txt: 'Kapat',
                              ),
                            ),
                            SizedBox(width: paddingM),
                            Expanded(
                              child: TSButton(
                                padding: EdgeInsets.zero,
                                buttonPadding: EdgeInsets.zero,
                                onTap: () {
                                  onClose(_cNote.text.trim());
                                  Navigator.of(context,rootNavigator: true).pop();
                                  },
                                txt: 'Not Ekle',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: paddingS),
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
