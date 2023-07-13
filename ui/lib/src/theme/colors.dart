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

  // background
  final primaryBackground = const Color(0xFFEBEFF2);
  final secondaryBackground = Colors.white;
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

  final greenMain = const Color(0xFF30A78B);

  final grey1 = const Color(0xFF8E8E93);

  final white100 = const Color(0xFFFFFFFF);
  final white400 = const Color(0x52FFFFFF);

  final black100 = const Color(0xFF25282B);

  // chip
  Color get chipTextBlack => black100;

  // shadow
  Color get shadow => purple200;

  // dialog
  Color get dialogOverlay => const Color(0xFF000000).withOpacity(0.35);

  // text
  final primaryText = const Color(0xFF25282B);
  final secondaryText = const Color(0xFF74767B);
  final errorText = const Color(0xFFD22D2D);
  final primaryButtonText = const Color(0xFF25282B);
  final secondaryButtonText = const Color(0xFFFFFFFF);
  final disabledButtonText = const Color(0xFF5F6366);
  final orangeText = const Color(0xFFB1742A);

  // button
  final disabledButton = const Color(0xFF323233);
  final fullRoundButton = const Color(0xFF292929);
  final focusButton = const Color(0xFF32D8A1);
  final primaryButton = const Color(0xFFFFFFFF);
  final chipDefaultBg = const Color(0xFFE5E5EA);

  // tip
  final mainGreen = const Color(0xFF10C469);
  final mainRed = const Color(0xFFD22D2D);
  final systemStatusActive = const Color(0xFF63C174);
}

class ColorsThemeDark implements ColorsTheme {
  ColorsThemeDark._();

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
  Color get greenMain => const Color(0xFF30A78B);

  @override
  final grey1 = const Color(0xFF8E8E93);

  @override
  final white100 = const Color(0xFFFFFFFF);

  @override
  final white400 = const Color(0x52FFFFFF);

  @override
  final black100 = const Color(0xFF25282B);

  @override
  Color get chipTextBlack => black100;

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
  Color get orangeText => const Color(0xFFB1742A);

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

  // tip
  @override
  Color get mainGreen => const Color(0xFF30A78B);

  @override
  Color get mainRed => const Color(0xFFFF7878);

  @override
  Color get systemStatusActive => const Color(0xFF63C174);
}
