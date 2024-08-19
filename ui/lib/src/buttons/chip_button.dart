import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';

enum ChipButtonStates {
  defaultState,
  activeState,
  inactiveState,
  disabled,
  danger,
}

enum MXCChipsEdgeType {
  hard,
  soft,
}

class MxcChipButton extends StatelessWidget {
  const MxcChipButton({
    required Key? key,
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
    this.iconData,
    this.iconSize,
    this.mxcChipsEdgeType = MXCChipsEdgeType.soft,
    this.primaryColor,
  }) : super(key: key);

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
  final MXCChipsEdgeType mxcChipsEdgeType;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry getBorderRadius(MXCChipsEdgeType mxcChipsEdgeType) {
      switch (mxcChipsEdgeType) {
        case MXCChipsEdgeType.hard:
          return const BorderRadius.all(Radius.zero);
        case MXCChipsEdgeType.soft:
          return const BorderRadius.all(Radius.circular(40));
      }
    }

    BoxDecoration resolveButtonDecoration(
      ChipButtonStates buttonState,
      MXCChipsEdgeType mxcChipsEdgeType,
    ) {
      switch (buttonState) {
        case ChipButtonStates.activeState:
          return BoxDecoration(
            color: backgroundColor ?? primaryColor ?? ColorsTheme.of(context).chipBgActive,
            borderRadius: getBorderRadius(mxcChipsEdgeType),
          );
        case ChipButtonStates.inactiveState:
          return BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: getBorderRadius(mxcChipsEdgeType),
            border: Border.all(
              color: primaryColor ?? ColorsTheme.of(context).chipBorderInactive,
            ),
          );
        case ChipButtonStates.defaultState:
          return BoxDecoration(
            color: backgroundColor ??
                ColorsTheme.of(context).chipDefaultBackground,
            borderRadius: getBorderRadius(mxcChipsEdgeType),
          );
        case ChipButtonStates.disabled:
          return BoxDecoration(
            color:
                backgroundColor ?? ColorsTheme.of(context).backgroundDisabled,
            borderRadius: getBorderRadius(mxcChipsEdgeType),
          );
        case ChipButtonStates.danger:
          return BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: getBorderRadius(mxcChipsEdgeType),
            border: Border.all(
              color: ColorsTheme.of(context).mainRed,
            ),
          );
      }
    }

    TextStyle resolveTextStyle(ChipButtonStates buttonState) {
      if (textStyle != null) {
        return textStyle!;
      }
      switch (buttonState) {
        case ChipButtonStates.activeState:
          return FontTheme.of(context).subtitle1().copyWith(
                color: ColorsTheme.of(context).chipTextBlack,
                fontWeight: FontWeight.w500,
              );
        case ChipButtonStates.inactiveState:
          return FontTheme.of(context).subtitle2().copyWith(
                color: primaryColor ?? ColorsTheme.of(context).chipTextInactive,
                fontWeight: FontWeight.w500,
              );
        case ChipButtonStates.defaultState:
          return FontTheme.of(context).subtitle2.primary();
        case ChipButtonStates.disabled:
          return FontTheme.of(context).subtitle2().copyWith(
                color: ColorsTheme.of(context).textDisabled,
              );
        case ChipButtonStates.danger:
          return FontTheme.of(context).subtitle2().copyWith(
                color: ColorsTheme.of(context).mainRed,
              );
      }
    }

    Icon resolveIcon() {
      switch (buttonState) {
        case ChipButtonStates.activeState:
          return Icon(
            iconData,
            color: iconColor ?? ColorsTheme.of(context).chipIconInactive,
            size: iconSize ?? 20,
          );
        case ChipButtonStates.inactiveState:
          return Icon(
            iconData,
            color: iconColor ?? ColorsTheme.of(context).chipTextInactive,
            size: iconSize ?? 20,
          );
        case ChipButtonStates.defaultState:
          return Icon(
            iconData,
            color: iconColor ?? ColorsTheme.of(context).iconPrimary,
            size: iconSize ?? 20,
          );
        case ChipButtonStates.disabled:
          return Icon(
            iconData,
            color: iconColor ?? ColorsTheme.of(context).textDisabled,
            size: iconSize ?? 20,
          );
        case ChipButtonStates.danger:
          return Icon(
            iconData,
            color: iconColor ?? ColorsTheme.of(context).mainRed,
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
        padding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: resolveButtonDecoration(buttonState, mxcChipsEdgeType),
        child: iconData == null
            ? Text(
                title,
                style: resolveTextStyle(buttonState),
                textAlign: TextAlign.center,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
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
