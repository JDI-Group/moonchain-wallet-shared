import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../bottom_sheets/info_bottom_sheet.dart';

class MXCInformationButton extends StatelessWidget {
  final List<InlineSpan> texts;
  final TooltipDirection popupDirection;
  MXCInformationButton(
      {Key? key,
      required this.texts,
      this.popupDirection = TooltipDirection.up})
      : super(key: key);

  final controller = SuperTooltipController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showInformationalBottomSheet(context, texts),
      child: Icon(
        Icons.info_rounded,
        color: ColorsTheme.of(context).btnBgWhite,
        size: 18,
      ),
    );
  }
}
