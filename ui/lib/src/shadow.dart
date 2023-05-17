import 'package:flutter/material.dart';

class MxcBoxShadow extends BoxShadow {
  const MxcBoxShadow({required Color color})
      : super(
          blurRadius: 7,
          color: color,
        );

  const MxcBoxShadow.custom({
    required Color color,
    required double blurRadius,
    Offset offset = Offset.zero,
  }) : super(
          blurRadius: blurRadius,
          color: color,
          offset: offset,
        );

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, blurSigma);
    assert(
      () {
        if (debugDisableShadows) result.maskFilter = null;
        return true;
      }(),
    );
    return result;
  }
}
