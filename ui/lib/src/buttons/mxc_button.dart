import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxc_ui/mxc_ui.dart';

enum MxcButtonType { primary, secondary, plain, pass, warning }

enum MxcButtonSize { xl, xxl }

class MxcButton extends StatefulWidget {
  /// [key] marked as required, because it's often needed for testing purposes
  const MxcButton({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MxcButtonType.primary,
    this.size = MxcButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.primary({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MxcButtonType.primary,
    this.size = MxcButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.secondary({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MxcButtonType.secondary,
    this.size = MxcButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.plain({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MxcButtonType.plain,
    this.size = MxcButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.primaryPass({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MxcButtonType.pass,
    this.size = MxcButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.primaryWarning({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MxcButtonType.warning,
    this.size = MxcButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.secondaryWarning({
    required Key? key,
    required this.title,
    required this.onTap,
    this.type = MxcButtonType.warning,
    this.size = MxcButtonSize.xxl,
    this.width,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  final MxcButtonType type;
  final MxcButtonSize size;
  final String title;
  final Color? titleColor;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final double? width;
  final String? icon;

  @override
  _MxcButtonState createState() => _MxcButtonState();
}

class _MxcButtonState extends State<MxcButton> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimate;
  bool _isTappedDown = false;

  double getHeight() => widget.size == MxcButtonSize.xl ? 44 : 60;

  Color getButtonColor() {
    if (widget.type == MxcButtonType.pass) {
      return ColorsTheme.of(context).systemStatusActive;
    }

    if (widget.type == MxcButtonType.warning && widget.color == null) {
      return ColorsTheme.of(context).buttonCritical;
    }

    if (widget.onTap == null) {
      return ColorsTheme.of(context).backgroundDisabled;
    }

    return widget.color ?? ColorsTheme.of(context).primaryButton;
  }

  Color getBorderColor() {
    if (widget.borderColor != null && widget.onTap != null) {
      return widget.borderColor!;
    }

    if (widget.onTap == null) {
      return ColorsTheme.of(context).backgroundDisabled;
    }

    if (widget.type == MxcButtonType.primary ||
        widget.type == MxcButtonType.secondary) {
      return ColorsTheme.of(context).borderWhite100;
    }

    if (widget.type == MxcButtonType.pass) {
      return ColorsTheme.of(context).systemStatusActive;
    }

    if (widget.type == MxcButtonType.warning) {
      return ColorsTheme.of(context).buttonCritical;
    }

    return Colors.transparent;
  }

  Color getTitleColor() {
    if (widget.onTap == null) {
      return ColorsTheme.of(context).textDisabled;
    }

    if (widget.titleColor != null) {
      return widget.titleColor!;
    }

    if (widget.type == MxcButtonType.primary) {
      return ColorsTheme.of(context).blackInvert;
    }

    if (widget.type == MxcButtonType.secondary) {
      return ColorsTheme.of(context).textWhite;
    }

    if (widget.type == MxcButtonType.warning && widget.color != null) {
      return ColorsTheme.of(context).mainRed;
    }

    if (widget.type == MxcButtonType.pass ||
        widget.type == MxcButtonType.warning) {
      return ColorsTheme.of(context).textBlack200;
    }

    return ColorsTheme.of(context).secondaryButtonText;
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
        color: getButtonColor(),
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
                if (widget.icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      widget.icon!,
                      colorFilter:
                          ColorFilter.mode(getTitleColor(), BlendMode.srcIn),
                    ),
                  ),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: FontTheme.of(context).body1().copyWith(
                        fontWeight: FontWeight.w500,
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
