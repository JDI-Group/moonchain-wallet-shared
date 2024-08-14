import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';

enum MXCWalletButtonType {
  primaryWhite,
  secondaryWhite,
  plainWhite,
  primary,
  secondary,
  plain,
  pass,
  warning,
}

enum MXCWalletButtonEdgeType {
  hard,
  soft,
}

enum MXCWalletButtonSize { xl, xxl }

class MxcButton extends StatefulWidget {
  /// [key] marked as required, because it's often needed for testing purposes
  const MxcButton({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.primary,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  const MxcButton.primaryWhite({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.primaryWhite,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  const MxcButton.secondaryWhite({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.secondaryWhite,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  const MxcButton.plainWhite({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.plainWhite,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  const MxcButton.primary({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.primary,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  const MxcButton.secondary({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.secondary,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  const MxcButton.plain({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.plain,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  const MxcButton.primaryPass({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.pass,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  const MxcButton.primaryWarning({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.warning,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  const MxcButton.secondaryWarning({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MXCWalletButtonType.warning,
    this.size = MXCWalletButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
    this.iconSize,
    this.titleSize,
    this.edgeType = MXCWalletButtonEdgeType.soft,
  }) : super(key: key);

  final MXCWalletButtonEdgeType edgeType;
  final MXCWalletButtonType type;
  final MXCWalletButtonSize size;
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
  _MXCButtonState createState() => _MXCButtonState();
}

class _MXCButtonState extends State<MxcButton> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimate;
  bool _isTappedDown = false;

  double getHeight() => widget.size == MXCWalletButtonSize.xl ? 44 : 60;

  Color getButtonBgColor() {
    if (widget.onTap == null) {
      return ColorsTheme.of(context).backgroundDisabledDark;
    }

    if (widget.color != null) {
      return widget.color!;
    }

    switch (widget.type) {
      case MXCWalletButtonType.primary:
        return ColorsTheme.of(context).btnBgBlue;
      case MXCWalletButtonType.primaryWhite:
        return ColorsTheme.of(context).btnBgWhite;
      case MXCWalletButtonType.pass:
        return ColorsTheme.of(context).systemStatusActive;
      case MXCWalletButtonType.warning:
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
      case MXCWalletButtonType.primary:
        return ColorsTheme.of(context).btnBgBlue;
      case MXCWalletButtonType.primaryWhite:
        return ColorsTheme.of(context).btnBgWhite;
      case MXCWalletButtonType.secondary:
        return ColorsTheme.of(context).btnSecondaryBlue;
      case MXCWalletButtonType.secondaryWhite:
        return ColorsTheme.of(context).borderWhite100;
      case MXCWalletButtonType.pass:
        return ColorsTheme.of(context).systemStatusActive;
      case MXCWalletButtonType.warning:
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
      case MXCWalletButtonType.primary:
        return ColorsTheme.of(context).btnTextInvert2;
      case MXCWalletButtonType.primaryWhite:
        return ColorsTheme.of(context).textBlack100;
      case MXCWalletButtonType.secondary:
        return ColorsTheme.of(context).btnSecondaryBlue;
      case MXCWalletButtonType.secondaryWhite:
      case MXCWalletButtonType.plainWhite:
        return ColorsTheme.of(context).textWhite;
      case MXCWalletButtonType.pass:
        return ColorsTheme.of(context).textBlack200;
      case MXCWalletButtonType.warning:
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

  BorderRadius getBorderRadius() => widget.edgeType == MXCWalletButtonEdgeType.soft
            ? BorderRadius.circular(40)
            : BorderRadius.zero;

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
        borderRadius: getBorderRadius(),
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) => startAnimate(),
          onTapCancel: () => endAnimate(),
          onTapUp: (_) => endAnimate(),
          child: Container(
            width: widget.width,
            height: getHeight(),
            decoration: BoxDecoration(
              borderRadius: getBorderRadius(),
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
                  style: FontTheme.of(context).body2().copyWith(
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
