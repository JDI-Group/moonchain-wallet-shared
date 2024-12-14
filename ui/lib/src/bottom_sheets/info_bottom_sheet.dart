import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mxc_ui/mxc_ui.dart';
import 'package:mxc_ui/src/bottom_sheets/base_bottom_sheet.dart';

Future<bool?> showInformationalBottomSheet(
    BuildContext context, List<InlineSpan> texts) async {
  return showBaseBottomSheet(
    context: context,
    content: InformationWidget(
      texts: texts,
    ),
  );
}

class InformationWidget extends StatelessWidget {
  final List<InlineSpan> texts;
  const InformationWidget({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    String translate(String text) => FlutterI18n.translate(context, text);

    return Container(
      decoration: BoxDecoration(
        color: ColorsTheme.of(context).layerSheetBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
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
    );
  }
}
