import 'package:flutter/material.dart';

class MxcChipButton extends StatelessWidget {
  const MxcChipButton(
      {required Key? key,
      required this.onTap,
      required this.title,
      this.filled = false,
      this.color,
      this.titleStyle,
      this.textSpace,
      this.shadowRadius,
      this.buttonDecoration,
      this.iconFillColor,
      this.height,
      this.width,
      this.alignIconStart,
      this.contentPadding,
      this.icon})
      : super(key: key);

  final bool filled;
  final VoidCallback? onTap;
  final String title;
  final Color? color;
  final TextStyle? titleStyle;
  final double? textSpace;
  final double? shadowRadius;
  final BoxDecoration? buttonDecoration;
  final EdgeInsets? contentPadding;
  final Color? iconFillColor;
  final double? width;
  final double? height;
  final Widget? icon;
  final bool? alignIconStart;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        padding: contentPadding,
        decoration: buttonDecoration,
        child: icon == null
            ? Text(
                title,
                style: titleStyle,
              )
            : Row(
                children: alignIconStart == true
                    ? [
                        icon!,
                        Text(
                          title,
                          style: titleStyle,
                        )
                      ]
                    : [
                        Text(
                          title,
                          style: titleStyle,
                        ),
                        icon!
                      ],
              ),
      ),
    );
  }
}
