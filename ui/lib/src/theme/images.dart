import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';
import 'package:provider/provider.dart';

class ImagesTheme {
  const ImagesTheme._();

  factory ImagesTheme.fromOption(MxcThemeOption option) {
    switch (option) {
      case MxcThemeOption.day:
        return const ImagesTheme._();
      case MxcThemeOption.night:
        return const ImagesThemeDark._();
    }
  }

  static ImagesTheme of(BuildContext context, {bool listen = true}) {
    return Provider.of<ImagesTheme>(context, listen: listen);
  }

  // login
  ImageProvider get mxc => const AssetImage(
        'assets/images/login/mxc.png',
        package: mxcUiPackageName,
      );
}

class ImagesThemeDark extends ImagesTheme {
  const ImagesThemeDark._() : super._();

  // login
}

extension ImageProviderExt on ImageProvider {
  ImageProvider withScale(double scale) {
    final source = this;
    if (source is AssetImage) {
      return ExactAssetImage(
        source.assetName,
        bundle: source.bundle,
        package: source.package,
        scale: scale,
      );
    }
    return source;
  }
}
