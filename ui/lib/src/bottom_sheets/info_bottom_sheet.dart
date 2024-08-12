import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mxc_ui/mxc_ui.dart';

Future<bool?> showInformationalBottomSheet(
    BuildContext context, List<InlineSpan> texts) {
  String translate(String text) => FlutterI18n.translate(context, text);

  return showModalBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    builder: (BuildContext context) => Container(
      padding: const EdgeInsets.only(
          top: Sizes.spaceNormal, bottom: Sizes.space3XLarge),
      decoration: BoxDecoration(
        color: ColorsTheme.of(context).layerSheetBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Sizes.spaceXLarge,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: Sizes.spaceNormal, end: Sizes.spaceNormal, bottom: 0),
              child: MxcAppBarEvenly.title(
                titleText: translate('information'),
              ),
            ),
            RichText(
              text: TextSpan(
                  style: FontTheme.of(context)
                      .subtitle1()
                      .copyWith(color: ColorsTheme.of(context).textPrimary),
                  children: texts),
            ),
            const SizedBox(
              height: Sizes.space3XLarge,
            ),
            MxcButton.primary(
              key: const ValueKey('okButton'),
              title: translate('ok'),
              onTap: () => Navigator.of(context).pop(false),
              size: MXCWalletButtonSize.xl,
            ),
          ],
        ),
      ),
    ),
  );
}
