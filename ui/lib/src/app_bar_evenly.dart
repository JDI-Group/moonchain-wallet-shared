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
    this.useContentPadding = false,
  });

  MxcAppBarEvenly.text({
    Key? key,
    required String titleText,
    String? leadingText,
    String? actionText,
    this.padding,
    Function()? onActionTap,
    bool isActionTap = false,
    this.useContentPadding = false,
    bool showCancel = true
  })  : title = Builder(
          builder: (context) => Text(
            titleText,
            style: FontTheme.of(context).body1().copyWith(
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading = Builder(
          builder: (context) => InkWell(
            onTap: appBarCloseHandlerBuilder(context),
            child: showCancel ? Text(
              leadingText ?? FlutterI18n.translate(context, 'cancel'),
              style: FontTheme.of(context).body1(),
              textAlign: TextAlign.left,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ) : Container()
          ),
        ),
        action = actionText != null
            ? Builder(
                builder: (context) => InkWell(
                  onTap: isActionTap ? onActionTap : null,
                  child: Text(
                    actionText,
                    style: isActionTap
                        ? FontTheme.of(context).body1().copyWith(
                              fontWeight: FontWeight.w500,
                            )
                        : FontTheme.of(context).body1.secondary().copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                    textAlign: TextAlign.right,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            : const SizedBox(),
        super(key: key);

  MxcAppBarEvenly.back({
    Key? key,
    required String titleText,
    String? actionText,
    this.padding,
    Function()? onActionTap,
    bool isActionTap = true,
    this.useContentPadding = false,
  })  : title = Builder(
          builder: (context) => Text(
            titleText,
            style: FontTheme.of(context).body1().copyWith(
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading = Builder(
          builder: (context) => InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 32,
                )),
          ),
        ),
        action = actionText != null
            ? Builder(
                builder: (context) => InkWell(
                  onTap: isActionTap ? onActionTap : null,
                  child: Text(
                    actionText,
                    style: isActionTap
                        ? FontTheme.of(context).body1().copyWith(
                              fontWeight: FontWeight.w500,
                            )
                        : FontTheme.of(context).body1.secondary().copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                    textAlign: TextAlign.right,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            : const SizedBox(),
        super(key: key);

  MxcAppBarEvenly.close({
    Key? key,
    required String titleText,
    Widget? action,
    this.padding,
    this.useContentPadding = false,
  })  : title = Builder(
          builder: (context) => Text(
            titleText,
            style: FontTheme.of(context).body1().copyWith(
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading = Builder(
          builder: (context) => InkWell(
            onTap: appBarPopHandlerBuilder(context),
            child: Container(
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.close_rounded,
                  size: 32,
                )),
          ),
        ),
        action = action != null
            ? Builder(
                builder: (context) => Container(
                  alignment: Alignment.centerRight,
                  child: action,
                ),
              )
            : const SizedBox(),
        super(key: key);

  MxcAppBarEvenly.title({
    Key? key,
    required String titleText,
    Widget? leading,
    Widget? action,
    this.padding,
    this.useContentPadding = false,
  })  : title = Builder(
          builder: (context) => Text(
            titleText,
            style: FontTheme.of(context).body1().copyWith(
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading = leading ?? const SizedBox(),
        action = action ?? const SizedBox(),
        super(key: key);

  final Widget title;
  final EdgeInsetsGeometry? padding;
  final Widget? leading;
  final Widget? action;
  final bool useContentPadding;

  @override
  Widget build(BuildContext context) {
    final leftAndRightPadding = useContentPadding ? 24.0 : 0.0;

    return Padding(
      padding: padding ??
          EdgeInsets.only(
            top: 16,
            bottom: 32,
            left: leftAndRightPadding,
            right: leftAndRightPadding,
          ),
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
