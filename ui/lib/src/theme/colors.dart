import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

class ColorsTheme {
  ColorsTheme._();

  factory ColorsTheme.fromOption(MxcThemeOption option) {
    switch (option) {
      case MxcThemeOption.day:
        return ColorsTheme._();
      case MxcThemeOption.night:
        return ColorsThemeDark._();
    }
  }

  static ColorsTheme of(BuildContext context, {bool listen = true}) {
    return Provider.of<ColorsTheme>(context, listen: listen);
  }

  final screenBackground = const Color(0xFFF1F2F4);
  Color get secondaryBackground => white100;
  Color get backgroundGrey6 => grey6;
  Color get backgroundLightGrey => const Color(0XFF212529);

  //primary
  final primary = const Color(0xFF0F46F4);
  final primary40 = const Color(0xFF062588);
  final primary50 = const Color(0xFF072A9C);
  final primary60 = const Color(0xFF082FAF);
  final primary70 = const Color(0xFF0934C3);
  final primary80 = const Color(0xFF0A3AD6);
  final primary90 = const Color(0xFF0B3FEA);
  final primary100 = const Color(0xFF2958F5);
  final primary200 = const Color(0xFF3C67F6);
  static const primary300 = Color(0xFF5077F7);
  final primary400 = const Color(0xFF6386F8);
  final primary500 = const Color(0xFF7795F9);
  final primary600 = const Color(0xFF8AA4F9);

  final darkBlue = const Color(0xff0E1629);
  final charcoalGray = const Color(0xff333333);

  // Border color
  Color get borderPrimary100 => primary100;
  Color get borderPrimary200 => primary200;

  // Disabled state
  final textDisabledDark = const Color(0xFF5F6366);
  final backgroundDisabledDark = const Color(0xFF323233);

  // Button color
  Color get btnBgWhite => white100;
  Color get btnBgBlue => primary;
  Color get btnTextBlack => textBlack100;
  Color get btnTextInvert1 => textBlack200;
  Color get btnTextInvert2 => textWhite;
  Color get btnIconInvert1 => iconBlack200;
  Color get btnIconInvert2 => iconWhite;
  Color get btnSecondaryBlue => primary200;

  // Chip color
  Color get chipBgActive => primary;
  Color get chipTextInvertActive => textWhite;
  Color get chipIconInvertActive => iconWhite;
  Color get chipBorderInactive => primary200;
  Color get chipTextInactive => primary200;
  Color get chipIconInactive => primary200;

  // background
  final primaryBackground = const Color(0xFFEBEFF2);
  // final secondaryBackground = Colors.white;
  final white = Colors.white;

  Color get cardBackground => white100;

  // indicator
  final onTertiary = const Color(0xFF171717);
  final tertiary = const Color(0xFFBFBFBF);

  // components
  final purpleMain = const Color(0xFF461AB2);
  final purple600 = const Color(0xFF2A0F69);
  final purple500 = const Color(0xFF6A47C0);
  final purple400 = const Color(0xFF8F75D0);
  final purple300 = const Color(0xFFB3A1DE);
  final purple200 = const Color(0xFFD8CFEE);
  final purple100 = const Color(0xFFF2F0F8);

  final mxcPurple = const Color(0xFF6300FF);
  final mxcPurple500 = const Color(0xFF8132FE);
  final mxcPurple400 = const Color(0xFFA065FE);
  final mxcPurple300 = const Color(0xFFBF97FD);
  final mxcPurple200 = const Color(0xFFDECAFD);
  final mxcPurple100 = const Color(0xFFF4EFFC);

  final bluePrimary = const Color(0XFF478DE0);

  final btcOrange = const Color(0xFFF7931A);

  final warningShadow = const Color(0XFFFFD426);

  final warning = const Color(0xFFD29621);

  final errorShadow = const Color(0XFFF04248);
  final error = const Color(0XFFF04349);

  final greenMain = const Color(0xFF1FB857);
  final greenSuccess = const Color(0XFF00DF80);
  final successShadow = const Color(0XFF00DF80);

  final grey1 = const Color(0xFF8E8E93);
  final grey2 = const Color(0xFFAEAEB2);
  final grey3 = const Color(0xFFC7C7CC);
  final grey4 = const Color(0xFFD1D1D6);
  final grey5 = const Color(0xFFE5E5EA);
  final grey6 = const Color(0xFFF2F2F7);

  final lightGray = const Color(0XFFC8C5C5);

  final darkGray = const Color(0xFF131618);

  Color get white500 => white100;
  final white400 = const Color(0x52FFFFFF);
  final white300 = const Color(0xFFD7D8D9);
  final white200 = const Color(0x99FFFFFF);
  final white100 = const Color(0xFFFFFFFF);

  Color get whiteInvert => black100;

  final black100 = const Color(0xFF25282B);
  final black200 = const Color(0x4025282B);
  final black300 = const Color(0x8025282B);

  final blackDeep = const Color(0xFF000000);

  Color get blackInvert => white100;

  // layerSheet
  Color get layerSheetBackground => darkGray;

  // border
  Color get borderWhiteInvert => whiteInvert;
  Color get borderWhite100 => white100;

  Color get borderGrey3 => grey3;

  // chip
  Color get chipActiveBackground => whiteInvert;
  Color get chipTextBlack => blackInvert;
  Color get chipIconBlack => blackInvert;

  Color get chipDefaultBackground => darkGray;

  Color get chipBorder => whiteInvert;

  // icon
  Color get iconPrimary => black100;
  Color get iconSecondary => textSecondary;
  Color get iconWhite => white100;
  Color get iconWhite32 => iconSecondary;
  Color get iconWhite16 => iconSecondary;
  Color get iconPurpleMain => purpleMain;
  Color get iconBlack200 => blackDeep;
  Color get iconBlack100 => black100;
  Color get iconWhiteInvert => whiteInvert;
  Color get iconBlackInvert => blackInvert;
  Color get iconGrey4 => grey4;
  Color get iconGrey3 => grey3;
  Color get iconGrey1 => grey1;
  Color get iconCritical => mainRed;
  Color get iconButtonBackgroundActive => primary;
  Color get iconButtonInvertActive => iconWhite;

  // shadow
  Color get shadow => purple200;

  // dialog
  Color get dialogOverlay => const Color(0xFF000000).withOpacity(0.35);

  // text
  final primaryButtonText = const Color(0xFF25282B);
  final secondaryButtonText = const Color(0xFFFFFFFF);
  final disabledButtonText = const Color(0xFF5F6366);
  final textDisabled = const Color(0xFFA4A7AD);

  Color get textError => const Color(0xFFD32740);
  Color get textSecondary => const Color(0xFF74767B);
  Color get textPrimary => black100;
  Color get textWhite => white100;
  Color get textWhite50 => textSecondary;
  Color get textWhite100 => textSecondary;
  Color get textBlack200 => blackDeep;
  Color get textBlack100 => black100;
  Color get textOrange => btcOrange;
  Color get textPurple500 => purple500;
  Color get snackbarText => const Color(0xFF000000);
  Color get textGrey1 => grey1;
  Color get textGrey2 => grey2;
  Color get textWhiteInvert => whiteInvert;
  Color get textBlackInvert => blackInvert;
  Color get textCritical => saturatedRed;

  // button
  final backgroundDisabled = const Color(0xFFE3E3E5);
  final fullRoundButton = const Color(0xFF292929);
  final focusButton = const Color(0xFF32D8A1);
  final primaryButton = const Color(0xFFFFFFFF);
  final chipDefaultBg = const Color(0xFFE5E5EA);
  final disabledButton = const Color(0xFF323233);
  Color get buttonCritical => saturatedRed;

  Color get buttonWhiteInvert => whiteInvert;
  Color get buttonBlackInvert => blackInvert;

  // tip
  final mainGreen = const Color(0xFF10C469);
  final mainRed = const Color(0xFFD22D2D);
  final saturatedRed = const Color(0xffD32740);
  final systemStatusActive = const Color(0xFF63C174);
  final systemStatusInActive = const Color(0xFFEC5E41);
  final systemStatusNotCritical = const Color(0xFFDB9036);
}

class ColorsThemeDark implements ColorsTheme {
  ColorsThemeDark._();

  //primary
  @override
  final primary = const Color(0xFF4C74F4);

  @override
  final primary40 = const Color(0xFF273E88);

  @override
  final primary50 = const Color(0xFF2D479C);

  @override
  final primary60 = const Color(0xFF3551AF);

  @override
  final primary70 = const Color(0xFF3B5AC3);

  @override
  final primary80 = const Color(0xFF4063D6);

  @override
  final primary90 = const Color(0xFF466CEA);

  @override
  final primary100 = const Color(0xFF6788F5);

  @override
  final primary200 = const Color(0xFF7996F6);

  @override
  final primary300 = const Color(0xFF8DA6F7);

  @override
  final primary400 = const Color(0xFFA1B6F8);

  @override
  final primary500 = const Color(0xFFB6C5F9);

  @override
  final primary600 = const Color(0xFFC7D3F9);

  @override
  final darkBlue = const Color(0xff0E1629);

  @override
  final charcoalGray = const Color(0xff333333);

  // Border color
  @override
  Color get borderPrimary100 => primary100;

  @override
  Color get borderPrimary200 => primary200;

  // Disabled state
  @override
  final textDisabledDark = const Color(0xFF5F6366);

  @override
  final backgroundDisabledDark = const Color(0xFF323233);

  // Button color
  @override
  Color get btnBgWhite => white100;

  @override
  Color get btnBgBlue => primary;

  @override
  Color get btnTextBlack => textBlack100;

  @override
  Color get btnTextInvert1 => textWhite;

  @override
  Color get btnTextInvert2 => textBlack200;

  @override
  Color get btnIconInvert1 => iconWhite;

  @override
  Color get btnIconInvert2 => iconBlack200;

  @override
  Color get btnSecondaryBlue => primary200;

  // Chip color
  @override
  Color get chipBgActive => primary;

  @override
  Color get chipTextInvertActive => textBlack200;

  @override
  Color get chipIconInvertActive => iconBlack200;

  @override
  Color get chipBorderInactive => primary200;

  @override
  Color get chipTextInactive => primary200;

  @override
  Color get chipIconInactive => primary200;

  // background
  @override
  Color get screenBackground => grey6;

  @override
  final lightGray = const Color(0XFFC8C5C5);

  @override
  Color get secondaryBackground => grey6;

  @override
  Color get backgroundGrey6 => grey6;

  @override
  Color get backgroundLightGrey => const Color(0XFF212529);

  // background
  @override
  final primaryBackground = const Color(0xFF111111);

  @override
  final onTertiary = const Color(0xFFBFBFBF);

  @override
  final tertiary = const Color(0xFF171717);

  @override
  final white = Colors.white;

  @override
  final cardBackground = const Color(0xFF2C2C2E);

  // components
  @override
  final purpleMain = const Color(0xFFA885E0);

  @override
  final purple600 = const Color(0xFFA885E0);

  @override
  final purple500 = const Color(0xFF967BC3);

  @override
  final purple400 = const Color(0xFF78639A);

  @override
  final purple300 = const Color(0xFF594C70);

  @override
  final purple200 = const Color(0xFF3B3447);

  @override
  final purple100 = const Color(0xFF34313C);

  @override
  final mxcPurple = const Color(0xFFB593EC);

  @override
  final mxcPurple500 = const Color(0xFF967BC3);

  @override
  final mxcPurple400 = const Color(0xFF78639A);

  @override
  final mxcPurple300 = const Color(0xFF594C70);

  @override
  final mxcPurple200 = const Color(0xFF3B3447);

  @override
  final mxcPurple100 = const Color(0xFF242228);

  @override
  final bluePrimary = const Color(0XFF478DE0);

  @override
  final btcOrange = const Color(0xFFF7931A);

  @override
  final warningShadow = const Color(0XFFFFD426);

  @override
  final warning = const Color(0xFFD29621);

  @override
  final errorShadow = const Color(0XFFF04248);

  @override
  final error = const Color(0XFFF04349);

  @override
  Color get greenMain => const Color(0xFF30A78B);

  @override
  Color get greenSuccess => const Color(0XFF00DF80);

  @override
  Color get successShadow => const Color(0XFF00DF80);

  @override
  final grey1 = const Color(0xFF8E8E93);

  @override
  final grey2 = const Color(0xFF636366);

  @override
  final grey3 = const Color(0xFF48484A);

  @override
  final grey4 = const Color(0xFF3A3A3C);

  @override
  final grey5 = const Color(0xFF2C2C2E);

  @override
  final grey6 = const Color(0xFF1C1C1E);

  @override
  final darkGray = const Color(0xFF131618);

  @override
  final white500 = const Color(0x29FFFFFF);

  @override
  final white400 = const Color(0x52FFFFFF);

  @override
  final white300 = const Color(0x80FFFFFF);

  @override
  final white200 = const Color(0x99FFFFFF);

  @override
  final white100 = const Color(0xFFFFFFFF);

  @override
  Color get whiteInvert => white100;

  @override
  final black100 = const Color(0xFF25282B);

  @override
  final black200 = const Color(0x4025282B);

  @override
  final black300 = const Color(0x8025282B);

  @override
  final blackDeep = const Color(0xFF000000);

  @override
  Color get blackInvert => black100;

  // layer sheet
  @override
  Color get layerSheetBackground => darkGray;

  // border
  @override
  Color get borderWhiteInvert => white100;

  @override
  Color get borderWhite100 => white100;

  @override
  Color get borderGrey3 => grey3;

  // chip
  @override
  Color get chipActiveBackground => whiteInvert;

  @override
  Color get chipTextBlack => blackInvert;

  @override
  Color get chipIconBlack => blackInvert;

  @override
  Color get chipDefaultBackground => darkGray;

  @override
  Color get chipBorder => whiteInvert;

  // icon
  @override
  Color get iconPrimary => white100;

  @override
  Color get iconSecondary => secondaryText;

  @override
  Color get iconWhite => white100;

  @override
  Color get iconWhite32 => white400;

  @override
  Color get iconWhite16 => white500;

  @override
  Color get iconPurpleMain => purpleMain;

  @override
  Color get iconBlack200 => blackDeep;

  @override
  Color get iconBlack100 => textBlack100;

  @override
  Color get iconWhiteInvert => whiteInvert;

  @override
  Color get iconBlackInvert => blackInvert;

  @override
  Color get iconGrey4 => grey4;

  @override
  Color get iconGrey3 => grey3;

  @override
  Color get iconGrey1 => grey1;

  @override
  Color get iconCritical => mainRed;

  @override
  Color get iconButtonBackgroundActive => primary;

  @override
  Color get iconButtonInvertActive => iconBlack200;

  @override
  Color get shadow => purple200;

  @override
  Color get dialogOverlay => const Color(0xFFFFFFFF).withOpacity(0.4);

  // text
  @override
  Color get primaryText => const Color(0xFFFFFFFF);

  @override
  Color get secondaryText => const Color(0xFFA5A6AC);

  @override
  Color get errorText => const Color(0xFFFC8383);

  @override
  Color get primaryButtonText => const Color(0xFF25282B);

  @override
  Color get secondaryButtonText => const Color(0xFFFFFFFF);

  @override
  final disabledButtonText = const Color(0xFF5F6366);

  @override
  Color get textDisabled => const Color(0xFF5F6366);

  @override
  Color get textError => const Color(0xFFD32740);

  @override
  Color get textSecondary => const Color(0xFFA5A6AC);

  @override
  Color get textPrimary => white100;

  @override
  Color get textWhite => white100;

  @override
  Color get textWhite50 => white300;

  @override
  Color get textWhite100 => white400;

  @override
  Color get textBlack200 => blackDeep;

  @override
  Color get textBlack100 => const Color(0xFF25282B);

  @override
  Color get textOrange => btcOrange;

  @override
  Color get textPurple500 => purple500;

  @override
  Color get snackbarText => const Color(0xFF000000);

  @override
  Color get textGrey1 => grey1;

  @override
  Color get textGrey2 => grey2;

  @override
  Color get textWhiteInvert => whiteInvert;

  @override
  Color get textBlackInvert => blackInvert;

  @override
  Color get textCritical => saturatedRed;

  // button
  @override
  Color get backgroundDisabled => const Color(0xFF323233);

  @override
  Color get fullRoundButton => const Color(0xFF484A4D);

  @override
  Color get focusButton => const Color(0xFF32D8A1);

  @override
  Color get primaryButton => const Color(0xFFFFFFFF);

  @override
  Color get chipDefaultBg => const Color(0xFF3A3A3C);

  @override
  final disabledButton = const Color(0xFF323233);

  @override
  Color get buttonCritical => saturatedRed;

  @override
  Color get buttonWhiteInvert => const Color(0xFFFFFFFF);

  @override
  Color get buttonBlackInvert => const Color(0xFF25282B);

  // tip
  @override
  Color get mainGreen => const Color(0xFF30A78B);

  @override
  Color get mainRed => const Color(0xFFFF7878);

  @override
  Color get saturatedRed => const Color(0xFFD32740);

  @override
  Color get systemStatusActive => const Color(0xFF63C174);

  @override
  final systemStatusInActive = const Color(0xFFEC5E41);

  @override
  final systemStatusNotCritical = const Color(0xFFDB9036);
}
