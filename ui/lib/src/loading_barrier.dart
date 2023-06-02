import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mxc_ui/mxc_ui.dart';

class LoadingBarrier extends StatelessWidget {
  const LoadingBarrier({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLoading,
          child: child,
        ),
        if (isLoading)
          Align(
            child: SizedBox(
              width: 50,
              height: 50,
              child: SpinKitPulse(
                color: ColorsTheme.of(context).purpleMain,
                size: 50,
              ),
            ),
          ),
      ],
    );
  }
}
