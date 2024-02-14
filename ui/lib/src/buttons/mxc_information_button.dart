import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';
import 'package:super_tooltip/super_tooltip.dart';

class MXCInformationButton extends StatelessWidget {
  final List<InlineSpan> texts;
  MXCInformationButton({
    Key? key,
    required this.texts,
  }) : super(key: key);

  final controller = SuperTooltipController();

  @override
  Widget build(BuildContext context) {
    return SuperTooltip(
      controller: controller,
      content: RichText(
        text: TextSpan(
            style: FontTheme.of(context)
                .subtitle1()
                .copyWith(color: ColorsTheme.of(context).chipTextBlack),
            children: texts),
      ),
      hideTooltipOnTap: true,
      popupDirection: TooltipDirection.up,
      showBarrier: true,
      showDropBoxFilter: true,
      sigmaX: 5,
      sigmaY: 5,
      backgroundColor: ColorsTheme.of(context).mainRed,
      borderRadius: 25,
      onShow: () => Future.delayed(const Duration(seconds: 5), () {
        if (controller.isVisible) {
          controller.hideTooltip();
        }
      }),
      child: Icon(
        Icons.info_rounded,
        color: ColorsTheme.of(context).mainRed,
      ),
    );
  }
}
