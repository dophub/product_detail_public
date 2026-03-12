import 'package:flutter/material.dart';

/// Uygulama genelinde tüm text style ler buradan çekilmektedir
/// İsimler 'Size - FontWight - Color' Formatında ayarlanmıştır

TextStyle s12W400Dark(BuildContext context) => Theme.of(context).textTheme.headlineMedium!;

TextStyle s12W500Dark(BuildContext context) => Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontWeight: FontWeight.w500,
    );

TextStyle s13W400Dark(BuildContext context) => Theme.of(context).textTheme.headlineSmall!;

TextStyle s13W600Dark(BuildContext context) => Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontWeight: FontWeight.w600,
    );

TextStyle s13W500Dark(BuildContext context) => Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontWeight: FontWeight.w500,
    );

TextStyle s14W400Dark(BuildContext context) => Theme.of(context).textTheme.bodyLarge!;

TextStyle s14W500Dark(BuildContext context) => Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.w500,
    );


TextStyle s16W400Dark(BuildContext context) => Theme.of(context).textTheme.titleSmall!;

TextStyle s16W600Dark(BuildContext context) => Theme.of(context).textTheme.titleSmall!.copyWith(
      fontWeight: FontWeight.w600,
    );
