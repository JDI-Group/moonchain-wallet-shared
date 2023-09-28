import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mxc_ui/mxc_ui.dart';
import 'package:rxdart/rxdart.dart';

class BottomFlowDialog extends StatefulWidget {
  const BottomFlowDialog({
    Key? key,
    required this.child,
    this.canPop = true
  }) : super(key: key);

  final Widget child;
  final bool canPop;

  static BottomFlowDialogState of(BuildContext context) {
    return Provider.of<BottomFlowDialogState>(context, listen: false);
  }

  static BottomFlowDialogState? maybeOf(BuildContext context) {
    try {
      return Provider.of<BottomFlowDialogState>(context, listen: false);
    } on ProviderNotFoundException {
      return null;
    }
  }

  static double calculateBorderRadius(double overscrollValue) {
    return Tween<double>(
      begin: bottomFlowDialogRoundedCornersRadius,
      end: 0,
    )
        .chain(CurveTween(curve: Curves.easeInCirc))
        .transform(overscrollValue / initialBottomFlowDialogOffset);
  }

  @override
  State<BottomFlowDialog> createState() => BottomFlowDialogState();
}

class BottomFlowDialogState extends State<BottomFlowDialog> {
  @override
  @protected
  BuildContext get context => super.context;

  final BehaviorSubject<double> _overscrollValue = BehaviorSubject.seeded(0);
  ValueStream<double> get overscrollValue => _overscrollValue;

  final List<ScrollReporterKey> _scrollReporters = [];
  final Map<ScrollReporterKey, double> _scrollReportersLastValue = {};

  ScrollReporterKey? get _scrollReporter =>
      _scrollReporters.isEmpty ? null : _scrollReporters.last;

  NavigatorState get parentNavigator => Navigator.of(context);

  void close<T>([T? result]) {
    Navigator.of(context).pop(result);
  }

  void unassignScrollReporter(ScrollReporterKey key) {
    _scrollReporters.remove(key);
    _scrollReportersLastValue.remove(key);
    if (_scrollReporter != null) {
      final previousValue = _scrollReportersLastValue[_scrollReporter];
      if (previousValue != null &&
          previousValue != _overscrollValue.valueOrNull) {
        _overscrollValue.add(previousValue);
      }
    }
  }

  ScrollReporterKey assignScrollReporter() {
    final key = ScrollReporterKey();
    _scrollReporters.add(key);
    return key;
  }

  bool shouldReactOnScrollChanges(ScrollReporterKey key) =>
      _scrollReporter != key;

  void reportScrollChange(ScrollReporterKey reporter, double offset) {
    if (offset < 0) {
      offset = 0;
    }
    if (offset > initialBottomFlowDialogOffset) {
      offset = initialBottomFlowDialogOffset;
    }
    _scrollReportersLastValue[reporter] = offset;
    if (_overscrollValue.valueOrNull != offset && reporter == _scrollReporter) {
      _overscrollValue.add(offset);
    }
  }

  Color get background => ColorsTheme.of(context).primaryBackground;

  double get expectedBorderRadius =>
      BottomFlowDialog.calculateBorderRadius(overscrollValue.valueOrNull ?? 0);

  @override
  void dispose() {
    _overscrollValue.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (!widget.canPop) {
            SystemNavigator.pop();
            return Future.value(false);
          }
          
          if (parentNavigator.canPop()) {
            parentNavigator.pop();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Provider.value(
          value: this,
          child: widget.child,
        ));
  }
}

class BottomDialogFirstPage<T> extends Page<T> {
  const BottomDialogFirstPage({required this.child});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      settings: this,
    );
  }
}

int _scrollReporterDebugCounter = 0;

class ScrollReporterKey {
  ScrollReporterKey() : debugIndex = _scrollReporterDebugCounter++;

  final int debugIndex;
}
