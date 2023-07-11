import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class MxcAppBarEvenly extends StatelessWidget {
  const MxcAppBarEvenly({
    super.key,
    required this.title,
    this.action,
    this.leading,
    this.padding,
  });

  MxcAppBarEvenly.text({
    Key? key,
    required String titleText,
    String? leadingText,
    String? actionText,
    this.padding,
    Function()? onActionTap,
    bool isActionTap = false,
  })  : title = Builder(
          builder: (context) => Text(
            titleText,
            style: FontTheme.of(context).body2(),
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading = Builder(
          builder: (context) => InkWell(
            onTap: appBarCloseHandlerBuilder(context),
            child: Text(
              leadingText ?? FlutterI18n.translate(context, 'cancel'),
              style: FontTheme.of(context).body1(),
              textAlign: TextAlign.left,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        action = actionText != null
            ? Builder(
                builder: (context) => InkWell(
                  onTap: isActionTap ? onActionTap : null,
                  child: Text(
                    actionText,
                    style: isActionTap
                        ? FontTheme.of(context).body2()
                        : FontTheme.of(context).body2.secondary(),
                    textAlign: TextAlign.right,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            : const SizedBox(),
        super(key: key);

  final Widget title;
  final EdgeInsetsGeometry? padding;
  final Widget? action;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 32),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          if (leading != null)
            Expanded(
              child: leading!,
            ),
          Expanded(
            flex: 3,
            child: title,
          ),
          if (action != null)
            Expanded(
              child: action!,
            ),
        ],
      ),
    );
  }
}

class MxcAppBarText extends StatelessWidget {
  const MxcAppBarText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: FontTheme.of(context).body1(),
    );
  }
}
