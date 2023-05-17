import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';

class BottomFlowDialogRoute<T> extends MaterialPageRoute<T> {
  BottomFlowDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    this.skipAnimation = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
        );

  final bool skipAnimation;

  @override
  Duration get transitionDuration =>
      skipAnimation ? Duration.zero : super.transitionDuration;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    child = BottomFlowDialog(
      child: child,
    );

    return LayoutBuilder(
      builder: (ctx, cnstr) => Stack(
        children: [
          Positioned.fill(
            child: FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutQuad,
                ),
              ),
              child: ColoredBox(
                color: ColorsTheme.of(context).primaryBackground,
              ),
            ),
          ),
          PositionedTransition(
            rect: RelativeRectTween(
              begin: RelativeRect.fromLTRB(
                0,
                cnstr.maxHeight,
                0,
                -cnstr.maxHeight,
              ),
              end: RelativeRect.fill,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutQuad,
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class BottomFlowDialogPageRoute<T> extends PageRoute<T>
    with CupertinoRouteTransitionMixin<T> {
  BottomFlowDialogPageRoute({
    required this.builder,
    RouteSettings? settings,
    this.maintainState = true,
    this.skipAnimation = false,
  }) : super(
          settings: settings,
        );

  @override
  String? get title => null;

  @override
  final bool maintainState;

  final WidgetBuilder builder;

  final bool skipAnimation;

  @override
  bool get opaque => false;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  Color? get barrierColor => null;

  @override
  Duration get transitionDuration =>
      skipAnimation ? Duration.zero : super.transitionDuration;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final bool linearTransition =
        CupertinoRouteTransitionMixin.isPopGestureInProgress(this);
    final positionAnimation = linearTransition
        ? animation
        : CurvedAnimation(
            parent: animation,
            curve: Curves.linearToEaseOut,
            reverseCurve: Curves.easeInToLinear,
          );
    final clipTopOffset = initialBottomFlowDialogOffset -
        (BottomFlowDialog.maybeOf(context)?.overscrollValue.valueOrNull ?? 0);
    final clipCornersRadius =
        BottomFlowDialog.maybeOf(context)?.expectedBorderRadius ??
            bottomFlowDialogRoundedCornersRadius;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInCirc,
              ),
            ),
            child: ColoredBox(
              color: ColorsTheme.of(context).primaryBackground,
            ),
          ),
        ),
        ClipRRect(
          clipper: BottomFlowDialogPageRouteClipper(
            animation: positionAnimation,
            roundedCornersRadius: animation.isCompleted ? 0 : clipCornersRadius,
            offset: animation.isCompleted ? 0 : clipTopOffset,
          ), // this is a trick to remove shadow from cupertino's transions
          child: super.buildTransitions(
            context,
            animation,
            secondaryAnimation,
            child,
          ),
        )
      ],
    );
  }
}

class BottomFlowDialogPageRouteClipper extends CustomClipper<RRect> {
  BottomFlowDialogPageRouteClipper({
    required this.offset,
    required this.roundedCornersRadius,
    required this.animation,
  });

  final double offset;
  final double roundedCornersRadius;
  final Animation<double> animation;

  @override
  RRect getClip(Size size) {
    return RRect.fromLTRBAndCorners(
      (1 - animation.value) * size.width,
      offset,
      size.width,
      size.height,
      topLeft: Radius.circular(roundedCornersRadius),
      topRight: Radius.circular(roundedCornersRadius),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return true;
  }
}
