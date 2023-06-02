import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  ImageProvider get datadash => const AssetImage(
        'assets/images/splash/datadash.png',
        package: mxcUiPackageName,
      );

  ImageProvider get mxc => const AssetImage(
        'assets/images/splash/mxc.png',
        package: mxcUiPackageName,
      );
    ImageProvider get bitcoin => const AssetImage(
        'assets/images/bitcoin.png',
        package: mxcUiPackageName,
      );

        ImageProvider get sliderPlaceHolder => const AssetImage(
        'assets/images/slider_placeholder.png',
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
