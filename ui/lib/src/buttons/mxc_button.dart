import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxc_ui/mxc_ui.dart';

enum MxcButtonType { primary, secondary, plain, sucess, failure }

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
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.primary({
    required Key? key,
    required this.title,
    required this.onTap,
    this.buttonType = MxcButtonType.primary,
    this.buttonSize = MxcButtonSize.xxl,
    this.fillWidth = true,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.secondary({
    required Key? key,
    required this.title,
    required this.onTap,
    this.buttonType = MxcButtonType.secondary,
    this.buttonSize = MxcButtonSize.xxl,
    this.fillWidth = true,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.plain({
    required Key? key,
    required this.title,
    required this.onTap,
    this.buttonType = MxcButtonType.plain,
    this.buttonSize = MxcButtonSize.xxl,
    this.fillWidth = true,
    this.titleColor,
    this.color = Colors.transparent,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  const MxcButton.primarySuccess({
    required Key? key,
    required this.title,
    required this.onTap,
    this.buttonType = MxcButtonType.sucess,
    this.buttonSize = MxcButtonSize.xxl,
    this.fillWidth = true,
    this.titleColor,
    this.color,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  final MxcButtonType buttonType;
  final MxcButtonSize buttonSize;
  final String title;
  final Color? titleColor;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final bool fillWidth;
  final String? icon;

  @override
  _MxcButtonState createState() => _MxcButtonState();
}

class _MxcButtonState extends State<MxcButton> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimate;
  bool _isTappedDown = false;

  double getHeight() => widget.buttonSize == MxcButtonSize.xl ? 44 : 60;

  Color getButtonColor() {
    if (widget.buttonType == MxcButtonType.sucess) {
      return ColorsTheme.of(context).systemStatusActive;
    }

    if (widget.buttonType == MxcButtonType.failure) {
      return ColorsTheme.of(context).buttonCritical;
    }

    if (widget.onTap == null) {
      return ColorsTheme.of(context).disabledButton;
    }

    return widget.color ?? ColorsTheme.of(context).primaryButton;
  }

  Color getBorderColor() {
    if (widget.borderColor != null && widget.onTap != null) {
      return widget.borderColor!;
    }

    if (widget.onTap == null) {
      return ColorsTheme.of(context).disabledButton;
    }

    if (widget.buttonType == MxcButtonType.primary ||
        widget.buttonType == MxcButtonType.secondary) {
      return ColorsTheme.of(context).primaryButton;
    }

    if (widget.buttonType == MxcButtonType.sucess) {
      return ColorsTheme.of(context).systemStatusActive;
    }

    if (widget.buttonType == MxcButtonType.failure) {
      return ColorsTheme.of(context).buttonCritical;
    }

    return Colors.transparent;
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
          // onLongPressDown: (_) => startAnimate(),
          onTapUp: (_) => endAnimate(),
          // onLongPressUp: () => endAnimate(),
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
                                ? widget.titleColor ??
                                    ColorsTheme.of(context).primaryButtonText
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
      ),
    );
  }
}
