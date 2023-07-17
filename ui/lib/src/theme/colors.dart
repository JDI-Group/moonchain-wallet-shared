import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

class ColorsTheme {
  ColorsTheme._();

  factory ColorsTheme.fromOption(MxcThemeOption option) {
    switch (option) {
      case MxcThemeOption.day:
        return ColorsThemeDark._();
      // return ColorsTheme._();
      case MxcThemeOption.night:
        return ColorsThemeDark._();
    }
  }

  static ColorsTheme of(BuildContext context, {bool listen = true}) {
    return Provider.of<ColorsTheme>(context, listen: listen);
  }

  final screenBackground = const Color(0xFFF1F2F4);

  // background
  final primaryBackground = const Color(0xFFEBEFF2);
  // final secondaryBackground = Colors.white;
  final white = Colors.white;
  final box = Colors.white;

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

  final btcOrange = const Color(0xFFF7931A);

  final greenMain = const Color(0xFF30A78B);

  final grey1 = const Color(0xFF8E8E93);
  final grey2 = const Color(0xFFAEAEB2);
  final grey3 = const Color(0xFFC7C7CC);
  final grey4 = const Color(0xFFD1D1D6);
  final grey5 = const Color(0xFFE5E5EA);
  final grey6 = const Color(0xFFF2F2F7);

  Color get white500 => white100;
  final white400 = const Color(0x52FFFFFF);
  final white300 = const Color(0xFFD7D8D9);
  final white200 = const Color(0x99FFFFFF);
  final white100 = const Color(0xFFFFFFFF);

  Color get whiteInverted => black100;

  final black100 = const Color(0xFF25282B);
  final black200 = const Color(0x4025282B);
  final black300 = const Color(0x8025282B);

  final blackDeep = const Color(0xFF000000);

  Color get blackInverted => white100;

  // layerSheet
  Color get layerSheetBackground => white100;

  // border
  Color get borderWhiteInverted => whiteInverted;

  Color get borderGrey3 => grey3;

  // chip
  Color get chipActiveBackground => whiteInverted;
  Color get chipTextBlack => blackInverted;
  Color get chipIconBlack => blackInverted;

  Color get chipDefaultBackground => grey4;

  Color get chipBorder => whiteInverted;

  // icon
  Color get iconPrimary => black100;
  Color get iconSecondary => textSecondary;
  Color get iconWhite => white100;
  Color get iconWhite32 => iconSecondary;
  Color get iconWhite16 => iconSecondary;
  Color get iconPurpleMain => purpleMain;
  Color get iconBlack200 => blackDeep;
  Color get iconBlack100 => black100;
  Color get iconWhiteInverted => whiteInverted;
  Color get iconBlackInverted => blackInverted;
  Color get iconGrey4 => grey4;
  Color get iconGrey3 => grey3;
  Color get iconGrey1 => grey1;
  Color get iconCritical => mainRed;

  // shadow
  Color get shadow => purple200;

  // dialog
  Color get dialogOverlay => const Color(0xFF000000).withOpacity(0.35);

  // text
  final primaryButtonText = const Color(0xFF25282B);
  final secondaryButtonText = const Color(0xFFFFFFFF);
  final disabledButtonText = const Color(0xFF5F6366);

  Color get textError => const Color(0xFFD22D2D);
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
  Color get textWhiteInverted => whiteInverted;
  Color get textBlackInverted => blackInverted;
  Color get textCritical => mainRed;

  // button
  final disabledButton = const Color(0xFF323233);
  final fullRoundButton = const Color(0xFF292929);
  final focusButton = const Color(0xFF32D8A1);
  final primaryButton = const Color(0xFFFFFFFF);
  final chipDefaultBg = const Color(0xFFE5E5EA);
  Color get buttonCritical => mainRed;

  Color get buttonWhiteInverted => const Color(0xFFFFFFFF);
  Color get buttonBlackInverted => const Color(0xFF25282B);

  // tip
  final mainGreen = const Color(0xFF10C469);
  final mainRed = const Color(0xFFD22D2D);
  final systemStatusActive = const Color(0xFF63C174);
  final systemStatusInActive = const Color(0xFFEC5E41);
}

class ColorsThemeDark implements ColorsTheme {
  ColorsThemeDark._();

  // background
  @override
  final screenBackground = const Color(0xFF1C1C1E);

  // background
  @override
  final primaryBackground = const Color(0xFF111111);

  @override
  final secondaryBackground = const Color(0xFF1C1C1E);

  @override
  final onTertiary = const Color(0xFFBFBFBF);

  @override
  final tertiary = const Color(0xFF171717);

  @override
  final white = Colors.white;

  @override
  final box = const Color(0xFF2C2C2E);

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
  final btcOrange = const Color(0xFFF7931A);

  @override
  Color get greenMain => const Color(0xFF30A78B);

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
  Color get whiteInverted => white100;

  @override
  final black100 = const Color(0xFF25282B);

  @override
  final black200 = const Color(0x4025282B);

  @override
  final black300 = const Color(0x8025282B);

  @override
  final blackDeep = const Color(0xFF000000);

  @override
  Color get blackInverted => black100;

  // layer sheet
  @override
  Color get layerSheetBackground => const Color(0xFF2C2C2E);

  // border
  @override
  Color get borderWhiteInverted => black100;

  @override
  Color get borderGrey3 => grey3;

  // chip
  @override
  Color get chipActiveBackground => whiteInverted;

  @override
  Color get chipTextBlack => blackInverted;

  @override
  Color get chipIconBlack => blackInverted;

  @override
  Color get chipDefaultBackground => grey4;

  @override
  Color get chipBorder => whiteInverted;

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
  Color get iconWhiteInverted => whiteInverted;

  @override
  Color get iconBlackInverted => blackInverted;

  @override
  Color get iconGrey4 => grey4;

  @override
  Color get iconGrey3 => grey3;

  @override
  Color get iconGrey1 => grey1;

  @override
  Color get iconCritical => mainRed;

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
  Color get disabledButtonText => const Color(0xFF5F6366);

  @override
  Color get textError => const Color(0xFFFC8383);

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
  Color get textWhiteInverted => whiteInverted;

  @override
  Color get textBlackInverted => blackInverted;

  @override
  Color get textCritical => mainRed;

  // button
  @override
  Color get disabledButton => const Color(0xFF323233);

  @override
  Color get fullRoundButton => const Color(0xFF484A4D);

  @override
  Color get focusButton => const Color(0xFF32D8A1);

  @override
  Color get primaryButton => const Color(0xFFFFFFFF);

  @override
  Color get chipDefaultBg => const Color(0xFF3A3A3C);

  @override
  Color get buttonCritical => mainRed;

  @override
  Color get buttonWhiteInverted => const Color(0xFFFFFFFF);

  @override
  Color get buttonBlackInverted => const Color(0xFF25282B);

  // tip
  @override
  Color get mainGreen => const Color(0xFF30A78B);

  @override
  Color get mainRed => const Color(0xFFFF7878);

  @override
  Color get systemStatusActive => const Color(0xFF63C174);

  @override
  final systemStatusInActive = const Color(0xFFEC5E41);
}
