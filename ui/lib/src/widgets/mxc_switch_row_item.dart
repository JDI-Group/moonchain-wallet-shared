import 'package:flutter/cupertino.dart';
import 'package:mxc_ui/mxc_ui.dart';

class MXCSwitchRowItem extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool)? onChanged;
  final bool enabled;
  final Widget? textTrailingWidget;
  final EdgeInsets? paddings;
  final Color? switchActiveColor;

  /// Only font size & weight are supported.
  final TextStyle? titleStyle;
  const MXCSwitchRowItem(
      {super.key,
      required this.title,
      required this.value,
      this.onChanged,
      required this.enabled,
      this.textTrailingWidget,
      this.paddings,
      this.switchActiveColor,
      this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings ?? EdgeInsets.zero,
      child: Row(
        children: [
          Text(
            title,
            style: FontTheme.of(context).body2.primary().copyWith(
                fontSize: titleStyle?.fontSize,
                fontWeight: titleStyle?.fontWeight),
          ),
          if (textTrailingWidget != null) ...[
            const SizedBox(
              width: Sizes.spaceXSmall,
            ),
            textTrailingWidget!
          ],
          const Spacer(),
          const SizedBox(
            width: Sizes.spaceXSmall,
          ),
          CupertinoSwitch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: switchActiveColor,
          ),
        ],
      ),
    );
  }
}
