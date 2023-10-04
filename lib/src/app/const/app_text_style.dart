import 'package:flutter/material.dart';

/// Uygulama genelinde tüm text style ler buradan çekilmektedir
/// İsimler 'Size - FontWight - Color' Formatında ayarlanmıştır

TextStyle s12W700Dark(BuildContext context) =>
    Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700);

TextStyle s14W400Dark(BuildContext context) => Theme.of(context).textTheme.titleLarge!;

TextStyle s16W400Dark(BuildContext context) => Theme.of(context).textTheme.titleSmall!;

TextStyle s16W700Dark(BuildContext context) =>
    Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700);

TextStyle s18W700Dark(BuildContext context) =>
    Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700);
