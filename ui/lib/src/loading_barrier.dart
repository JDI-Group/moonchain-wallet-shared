import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mxc_ui/mxc_ui.dart';

class LoadingBarrier extends StatefulWidget {
  const LoadingBarrier({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<LoadingBarrier> createState() => _LoadingBarrierState();
}

class _LoadingBarrierState extends State<LoadingBarrier> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    // Show overlay immediately if isLoading is true initially
    if (widget.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showOverlay();
      });
    }
  }

  @override
  void didUpdateWidget(LoadingBarrier oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Use post-frame callback to avoid build phase issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show overlay when isLoading becomes true
      if (widget.isLoading && _overlayEntry == null) {
        _showOverlay();
      } 
      // Hide overlay when isLoading becomes false
      else if (!widget.isLoading && _overlayEntry != null) {
        _hideOverlay();
      }
    });
  }

  void _showOverlay() {
    // Safety check to avoid duplicate overlays
    if (_overlayEntry != null) return;
    
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: ColoredBox(
          color: Colors.transparent,
          child: Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: SpinKitPulse(
                color: ColorsTheme.of(context).purpleMain,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
    
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}