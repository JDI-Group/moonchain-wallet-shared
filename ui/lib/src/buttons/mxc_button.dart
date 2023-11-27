import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';

enum AxsButtonType {
  primaryWhite,
  secondaryWhite,
  plainWhite,
  primary,
  secondary,
  plain,
  pass,
  warning,
}

enum AxsButtonSize { xl, xxl }

class MxcButton extends StatefulWidget {
  /// [key] marked as required, because it's often needed for testing purposes
  const MxcButton(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.primary,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  const MxcButton.primaryWhite(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.primaryWhite,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  const MxcButton.secondaryWhite(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.secondaryWhite,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color = Colors.transparent,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  const MxcButton.plainWhite(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.plainWhite,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color = Colors.transparent,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  const MxcButton.primary(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.primary,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  const MxcButton.secondary(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.secondary,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color = Colors.transparent,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  const MxcButton.plain(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.plain,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color = Colors.transparent,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  const MxcButton.primaryPass(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.pass,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  const MxcButton.primaryWarning(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.warning,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  const MxcButton.secondaryWarning(
      {required Key? key,
      required this.title,
      required this.onTap,
      this.type = AxsButtonType.warning,
      this.size = AxsButtonSize.xxl,
      this.width,
      this.titleColor,
      this.color = Colors.transparent,
      this.borderColor,
      this.icon,
      this.iconSize,
      this.titleSize})
      : super(key: key);

  final AxsButtonType type;
  final AxsButtonSize size;
  final String title;
  final Color? titleColor;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final double? width;
  final IconData? icon;
  final double? iconSize;
  final double? titleSize;

  @override
  _AxsButtonState createState() => _AxsButtonState();
}

class _AxsButtonState extends State<MxcButton> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimate;
  bool _isTappedDown = false;

  double getHeight() => widget.size == AxsButtonSize.xl ? 44 : 60;

  Color getButtonBgColor() {
    if (widget.onTap == null) {
      return ColorsTheme.of(context).backgroundDisabledDark;
    }

    if (widget.color != null) {
      return widget.color!;
    }

    switch (widget.type) {
      case AxsButtonType.primary:
        return ColorsTheme.of(context).btnBgBlue;
      case AxsButtonType.primaryWhite:
        return ColorsTheme.of(context).btnBgWhite;
      case AxsButtonType.pass:
        return ColorsTheme.of(context).systemStatusActive;
      case AxsButtonType.warning:
        return ColorsTheme.of(context).buttonCritical;
      default:
        return Colors.transparent;
    }
  }

  Color getBorderColor() {
    if (widget.onTap == null) {
      return ColorsTheme.of(context).backgroundDisabledDark;
    }

    if (widget.borderColor != null) {
      return widget.borderColor!;
    }

    switch (widget.type) {
      case AxsButtonType.primary:
        return ColorsTheme.of(context).btnBgBlue;
      case AxsButtonType.primaryWhite:
        return ColorsTheme.of(context).btnBgWhite;
      case AxsButtonType.secondary:
        return ColorsTheme.of(context).btnSecondaryBlue;
      case AxsButtonType.secondaryWhite:
        return ColorsTheme.of(context).borderWhite100;
      case AxsButtonType.pass:
        return ColorsTheme.of(context).systemStatusActive;
      case AxsButtonType.warning:
        return ColorsTheme.of(context).buttonCritical;
      default:
        return Colors.transparent;
    }
  }

  Color getTitleColor() {
    if (widget.onTap == null) {
      return ColorsTheme.of(context).textDisabledDark;
    }

    if (widget.titleColor != null) {
      return widget.titleColor!;
    }

    switch (widget.type) {
      case AxsButtonType.primary:
        return ColorsTheme.of(context).btnTextInvert2;
      case AxsButtonType.primaryWhite:
        return ColorsTheme.of(context).textBlack100;
      case AxsButtonType.secondary:
        return ColorsTheme.of(context).btnSecondaryBlue;
      case AxsButtonType.secondaryWhite:
      case AxsButtonType.plainWhite:
        return ColorsTheme.of(context).textWhite;
      case AxsButtonType.pass:
        return ColorsTheme.of(context).textBlack200;
      case AxsButtonType.warning:
        return ColorsTheme.of(context).textCritical;
      default:
        return Colors.transparent;
    }
  }

  @override
  void initState() {
    super.initState();

    initAnimation();
  }

  void initAnimation() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    _scaleAnimate = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.35,
          0.7,
          curve: Curves.ease,
        ),
      ),
    );

    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     endAnimate();
    //   }
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void startAnimate() {
    if (mounted) {
      setState(() {
        _isTappedDown = true;
        _animationController.reset();
        _animationController.forward();
      });
    }
  }

  void endAnimate() => setState(() => _isTappedDown = false);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: (_isTappedDown &&
              widget.onTap != null &&
              _animationController.isAnimating)
          ? _scaleAnimate.value
          : 1.0,
      child: Material(
        color: getButtonBgColor(),
        borderRadius: BorderRadius.circular(40),
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) => startAnimate(),
          onTapCancel: () => endAnimate(),
          onTapUp: (_) => endAnimate(),
          child: Container(
            width: widget.width,
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
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon!,
                    size: widget.iconSize,
                    color: getTitleColor(),
                  ),
                  const SizedBox(width: Sizes.spaceXSmall),
                ],
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: FontTheme.of(context).body1().copyWith(
                        fontSize: widget.titleSize,
                        fontWeight: FontWeight.w600,
                        color: getTitleColor(),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
