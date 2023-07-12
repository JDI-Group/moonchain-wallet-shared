import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';
import 'package:provider/provider.dart';

class FontTheme {
  FontTheme(this._colorsTheme);

  final ColorsTheme _colorsTheme;

  static FontTheme of(BuildContext context, {bool listen = true}) {
    return Provider.of<FontTheme>(context, listen: listen);
  }

  TextStyle get _baseTextStyle => TextStyle(
        package: mxcUiPackageName,
        color: _colorsTheme.primaryText,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        height: 1.33333,
        decoration: TextDecoration.none,
      );

  TextStylePack get caption1 =>
      TextStylePack(_colorsTheme, _baseTextStyle.copyWith(fontSize: 12));
  TextStylePack get caption2 => TextStylePack(_colorsTheme,
      _baseTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 12));

  TextStylePack get subtitle1 =>
      TextStylePack(_colorsTheme, _baseTextStyle.copyWith(fontSize: 14));
  TextStylePack get subtitle2 => TextStylePack(_colorsTheme,
      _baseTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14));

  TextStylePack get body1 =>
      TextStylePack(_colorsTheme, _baseTextStyle.copyWith(fontSize: 16));
  TextStylePack get body2 => TextStylePack(_colorsTheme,
      _baseTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16));

  TextStylePack get h2 => TextStylePack(_colorsTheme,
      _baseTextStyle.copyWith(fontSize: 60, fontWeight: FontWeight.w300));

  TextStylePack get h3 =>
      TextStylePack(_colorsTheme, _baseTextStyle.copyWith(fontSize: 48));

  TextStylePack get h4 =>
      TextStylePack(_colorsTheme, _baseTextStyle.copyWith(fontSize: 34));

  TextStylePack get h5 =>
      TextStylePack(_colorsTheme, _baseTextStyle.copyWith(fontSize: 24));

  TextStylePack get h6 =>
      TextStylePack(_colorsTheme, _baseTextStyle.copyWith(fontSize: 20));

  TextStylePack get h7 => TextStylePack(_colorsTheme,
      _baseTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500));

  TextStylePack get h8 => TextStylePack(_colorsTheme,
      _baseTextStyle.copyWith(fontSize: 8, fontWeight: FontWeight.w500));
}

class TextStylePack {
  TextStylePack(this.colorsTheme, this._primary);

  final ColorsTheme colorsTheme;
  final TextStyle _primary;

  TextStyle call() => _primary;

  DecoratableTextStyle get primary =>
      DecoratableTextStyle(_primary.copyWith(color: colorsTheme.primaryText));

  DecoratableTextStyle get secondary =>
      DecoratableTextStyle(_primary.copyWith(color: colorsTheme.secondaryText));

  DecoratableTextStyle get alert =>
      DecoratableTextStyle(_primary.copyWith(color: colorsTheme.mainRed));

  DecoratableTextStyle get error =>
      DecoratableTextStyle(_primary.copyWith(color: colorsTheme.errorText));

  DecoratableTextStyle get primaryButton => DecoratableTextStyle(
        _primary.copyWith(color: colorsTheme.primaryButtonText),
      );

  DecoratableTextStyle get disabledButton => DecoratableTextStyle(
        _primary.copyWith(color: colorsTheme.disabledButton),
      );

  DecoratableTextStyle get white => DecoratableTextStyle(
        _primary.copyWith(color: colorsTheme.white),
      );
}

class DecoratableTextStyle {
  DecoratableTextStyle(this._inner);

  final TextStyle _inner;

  TextStyle call() => _inner;

  DecoratableTextStyle get underline => DecoratableTextStyle(
        _inner.copyWith(
          decoration: TextDecoration.underline,
        ),
      );
}
