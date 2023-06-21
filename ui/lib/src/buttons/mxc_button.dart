import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxc_ui/mxc_ui.dart';

enum MxcButtonType { primary, secondary, plain }

enum MxcButtonSize { xl, xxl }

class MxcButton extends StatefulWidget {
  /// [key] marked as required, because it's often needed for testing purposes
  const MxcButton({
    required Key? key,
    required this.title,
    required this.onTap,
    this.buttonType = MxcButtonType.primary,
    this.buttonSize = MxcButtonSize.xxl,
    this.fillWidth = true,
    this.color,
    this.icon,
  }) : super(key: key);

  const MxcButton.primary({
    required Key? key,
    required this.title,
    required this.onTap,
    this.buttonType = MxcButtonType.primary,
    this.buttonSize = MxcButtonSize.xxl,
    this.fillWidth = true,
    this.color,
    this.icon,
  }) : super(key: key);

  const MxcButton.secondary({
    required Key? key,
    required this.title,
    required this.onTap,
    this.buttonType = MxcButtonType.secondary,
    this.buttonSize = MxcButtonSize.xxl,
    this.fillWidth = true,
    this.color = Colors.transparent,
    this.icon,
  }) : super(key: key);

  const MxcButton.plain({
    required Key? key,
    required this.title,
    required this.onTap,
    this.buttonType = MxcButtonType.plain,
    this.buttonSize = MxcButtonSize.xxl,
    this.fillWidth = true,
    this.color = Colors.transparent,
    this.icon,
  }) : super(key: key);

  final MxcButtonType buttonType;
  final MxcButtonSize buttonSize;
  final String title;
  final Color? color;
  final VoidCallback? onTap;
  final bool fillWidth;
  final String? icon;

  @override
  _MxcButtonState createState() => _MxcButtonState();
}

class _MxcButtonState extends State<MxcButton> {
  bool hovering = false;

  double getHeight() => widget.buttonSize == MxcButtonSize.xl ? 44 : 60;

  Color getButtonColor() {
    var buttonColor = widget.color ?? ColorsTheme.of(context).primaryButton;

    if (widget.onTap == null) {
      buttonColor = ColorsTheme.of(context).disabledButton;
    } else if (hovering) {
      buttonColor = buttonColor.withOpacity(0.8);
    }

    return buttonColor;
  }

  Color getBorderColor() {
    if (widget.onTap == null) {
      return ColorsTheme.of(context).disabledButton;
    }

    if (widget.buttonType != MxcButtonType.plain) {
      return ColorsTheme.of(context).primaryButton;
    }

    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getButtonColor(),
      borderRadius: BorderRadius.circular(40),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (hovering) {
          if (hovering != this.hovering) {
            setState(() => this.hovering = hovering);
          }
        },
        child: Container(
          width: widget.fillWidth ? double.infinity : null,
          height: getHeight(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              width: 2,
              color: getBorderColor(),
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(
                    widget.icon!,
                  ),
                ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: widget.onTap != null
                    ? FontTheme.of(context).body2().copyWith(
                          color: widget.buttonType == MxcButtonType.primary
                              ? ColorsTheme.of(context).primaryButtonText
                              : ColorsTheme.of(context).secondaryButtonText,
                        )
                    : FontTheme.of(context).body2().copyWith(
                          color: ColorsTheme.of(context).disabledButtonText,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
