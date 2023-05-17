import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';
import 'package:provider/provider.dart';

class MxcScopedThemeData {
  MxcScopedThemeData({required this.primaryColor});

  final Color primaryColor;
}

class MxcScopedTheme extends StatelessWidget {
  // Use MxcScopedTheme when you want to set theme defaults on some scope.
  // E.g. set default color to btcYellow instead of mxcBlue for btc page.
  const MxcScopedTheme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final MxcScopedThemeData data;
  final Widget child;

  static MxcScopedThemeData of(BuildContext context, {bool listen = true}) {
    try {
      return Provider.of<MxcScopedThemeData>(context, listen: listen);
    } on ProviderNotFoundException {
      return MxcScopedThemeData(
        primaryColor: ColorsTheme.of(context, listen: listen).purpleMain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: data,
      child: child,
    );
  }
}
