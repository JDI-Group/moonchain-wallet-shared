import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';

class MxcFullRoundedButton extends StatefulWidget {
  const MxcFullRoundedButton({
    required Key? key,
    required this.title,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final String title;
  final Color? color;
  final VoidCallback? onTap;

  @override
  _MxcFullRoundedButtonState createState() => _MxcFullRoundedButtonState();
}

class _MxcFullRoundedButtonState extends State<MxcFullRoundedButton> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        widget.color ?? ColorsTheme.of(context).fullRoundButton;

    var buttonColor = primaryColor;

    if (widget.onTap == null) {
      buttonColor = ColorsTheme.of(context).disabledButton.withOpacity(0.2);
    } else if (hovering) {
      buttonColor = buttonColor.withOpacity(0.8);
    }

    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (hovering) {
          if (hovering != this.hovering) {
            setState(() => this.hovering = hovering);
          }
        },
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: widget.onTap != null
                ? FontTheme.of(context).body2.button()
                : FontTheme.of(context).body2.disabledButton(),
          ),
        ),
      ),
    );
  }
}
