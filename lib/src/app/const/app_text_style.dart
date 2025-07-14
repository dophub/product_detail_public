import 'package:flutter/material.dart';

/// Uygulama genelinde tüm text style ler buradan çekilmektedir
/// İsimler 'Size - FontWight - Color' Formatında ayarlanmıştır

// TextStyle s8W400Dark(BuildContext context) => Theme.of(context).textTheme.displayLarge!;
// TextStyle s10W400Dark(BuildContext context) => Theme.of(context).textTheme.displayMedium!;
// TextStyle s11W400Dark(BuildContext context) => Theme.of(context).textTheme.displaySmall!;
TextStyle s12W400Dark(BuildContext context) => Theme.of(context).textTheme.headlineMedium!;

TextStyle s12W500Dark(BuildContext context) => Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontWeight: FontWeight.w500,
    );

TextStyle s13W400Dark(BuildContext context) => Theme.of(context).textTheme.headlineSmall!;

TextStyle s13W500Dark(BuildContext context) => Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontWeight: FontWeight.w500,
    );

TextStyle s14W400Dark(BuildContext context) => Theme.of(context).textTheme.bodyLarge!;

TextStyle s14W500Dark(BuildContext context) => Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.w500,
    );

TextStyle s14W700Dark(BuildContext context) => Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.w700,
    );
// TextStyle s15W400Dark(BuildContext context) => Theme.of(context).textTheme.titleMedium!;
TextStyle s16W400Dark(BuildContext context) => Theme.of(context).textTheme.titleSmall!;

TextStyle s16W700Dark(BuildContext context) => Theme.of(context).textTheme.titleSmall!.copyWith(
      fontWeight: FontWeight.w700,
    );
// TextStyle s18W400Dark(BuildContext context) => Theme.of(context).textTheme.bodyMedium!;
// TextStyle s20W400Dark(BuildContext context) => Theme.of(context).textTheme.bodySmall!;
// TextStyle s22W400Dark(BuildContext context) => Theme.of(context).textTheme.titleLarge!;
// TextStyle s26W400Dark(BuildContext context) => Theme.of(context).textTheme.labelLarge!;
// TextStyle s28W400Dark(BuildContext context) => Theme.of(context).textTheme.labelSmall!;
