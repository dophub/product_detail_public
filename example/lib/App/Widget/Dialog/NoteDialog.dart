import 'package:flutter/material.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Button/TSButton.dart';
import 'package:example/App/Widget/Dialog/TSDialog.dart';

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
              width: SizeConfig.safeBlockHorizontal * 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: paddingM),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: paddingM),
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
                            const SizedBox(width: paddingM),
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
