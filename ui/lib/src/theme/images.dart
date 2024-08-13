import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  // Splash
  ImageProvider get axs => const AssetImage(
        'assets/images/splash/axs.png',
        package: mxcUiPackageName,
      );

  ImageProvider get axsWithTitle => const AssetImage(
        'assets/images/splash/axs-with-title.png',
        package: mxcUiPackageName,
      );

  ImageProvider get mxc => const AssetImage(
        'assets/images/splash/mxc.png',
        package: mxcUiPackageName,
      );

  ImageProvider get appTextLogo  => const AssetImage(
        'assets/images/splash/app_text_logo.png',
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
