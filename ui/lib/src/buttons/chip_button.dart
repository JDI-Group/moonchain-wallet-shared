import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';

enum ChipButtonStates { defaultState, activeState, inactiveState }

class MxcChipButton extends StatelessWidget {
  const MxcChipButton(
      {required Key? key,
      required this.onTap,
      required this.title,
      this.buttonState = ChipButtonStates.defaultState,
      this.backgroundColor,
      this.textSpace,
      this.shadowRadius,
      this.iconColor,
      this.textStyle,
      this.height,
      this.width,
      this.alignIconStart,
      this.contentPadding,
      this.iconData,this.iconSize})
      : super(key: key);

  final ChipButtonStates buttonState;
  final VoidCallback? onTap;
  final String title;
  final Color? backgroundColor;
  final double? textSpace;
  final double? shadowRadius;
  final EdgeInsets? contentPadding;
  final Color? iconColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final IconData? iconData;
  final bool? alignIconStart;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    BoxDecoration resolveButtonDecoration(ChipButtonStates buttonState) {
      switch (buttonState) {
        case ChipButtonStates.activeState:
          return BoxDecoration(
            color: backgroundColor ?? ColorsTheme.of(context).chipActiveBackground,
            borderRadius: BorderRadius.circular(40),
          );
        case ChipButtonStates.inactiveState:
          return BoxDecoration(
              color: backgroundColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: ColorsTheme.of(context).chipBorder));
        case ChipButtonStates.defaultState:
          return BoxDecoration(
            color: backgroundColor ?? ColorsTheme.of(context).chipDefaultBackground,
            borderRadius: BorderRadius.circular(40),
          );
      }
    }

    TextStyle resolveTextStyle(ChipButtonStates buttonState) {
      if (textStyle != null){
        return textStyle!;
      }
      switch (buttonState) {
        case ChipButtonStates.activeState:
          return FontTheme.of(context)
              .subtitle1()
              .copyWith(color: ColorsTheme.of(context).chipTextBlack);
        case ChipButtonStates.inactiveState:
          return FontTheme.of(context).subtitle1.primary();
        case ChipButtonStates.defaultState:
          return FontTheme.of(context).subtitle1.primary();
      }
    }

    Icon resolveIcon() {
      switch (buttonState) {
        case ChipButtonStates.activeState:
          return Icon(
            iconData,
            color: iconColor ?? ColorsTheme.of(context).chipIconBlack,
            size: iconSize ?? 20,
          );
        case ChipButtonStates.inactiveState:
          return Icon(
            iconData,
            color: iconColor ?? ColorsTheme.of(context).iconPrimary,
            size: iconSize ?? 20,
          );
        case ChipButtonStates.defaultState:
          return Icon(
            iconData,
            color: iconColor ?? ColorsTheme.of(context).iconPrimary,
            size: iconSize ?? 20,
          );
      }
    }

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        padding: contentPadding,
        decoration: resolveButtonDecoration(buttonState),
        child: iconData == null
            ? Text(
                title,
                style: resolveTextStyle(buttonState),
                textAlign: TextAlign.center,
              )
            : Row(
                children: alignIconStart == true
                    ? [
                        resolveIcon(),
                        const SizedBox(width: 4),
                        Text(
                          title,
                          style: resolveTextStyle(buttonState),
                        )
                      ]
                    : [
                        Text(
                          title,
                          style: resolveTextStyle(buttonState),
                        ),
                        const SizedBox(width: 4),
                        resolveIcon()
                      ],
              ),
      ),
    );
  }
}
