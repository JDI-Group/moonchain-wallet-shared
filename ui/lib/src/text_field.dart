import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxc_ui/mxc_ui.dart';

class MxcTextField extends FormField<String> {
  MxcTextField({
    required Key? key,
    String? label,
    required TextEditingController this.controller,
    String? hint,
    FormFieldValidator<String>? validator,
    TextInputAction? action,
    bool readOnly = false,
    MxcTextFieldButton? suffixButton,
    double width = double.infinity,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    String? suffixText,
    bool obscure = false,
    AutovalidateMode? autovalidateMode,
    String? followText,
    String? errorText,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          initialValue: controller.text,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (field) {
            return _MxcNonFormTextField(
              key: null,
              label: label,
              controller: controller,
              action: action,
              suffixButton: suffixButton,
              focusNode: focusNode,
              hint: hint,
              keyboardType: keyboardType,
              obscure: obscure,
              readOnly: readOnly,
              suffixText: suffixText,
              width: width,
              errorText: field.errorText ?? errorText,
              followText: followText,
              onChanged: onChanged,
            );
          },
        );

  MxcTextField.viewOnly({
    Key? key,
    String? label,
    required String text,
    String? hint,
    TextInputAction? action,
    MxcTextFieldButton? suffixButton,
    double width = double.infinity,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    String? suffixText,
    bool obscure = false,
    String? followText,
  })  : controller = null,
        super(
          key: key,
          builder: (s) => _MxcNonFormTextField.viewOnly(
            label: label,
            text: text,
            action: action,
            suffixButton: suffixButton,
            focusNode: focusNode,
            hint: hint,
            keyboardType: keyboardType,
            obscure: obscure,
            suffixText: suffixText,
            width: width,
            followText: followText,
          ),
        );

  MxcTextField.disabled({
    Key? key,
    String? label,
    required String text,
    String? hint,
    MxcTextFieldButton? suffixButton,
    double width = double.infinity,
    FocusNode? focusNode,
    String? suffixText,
    bool obscure = false,
  })  : controller = null,
        super(
          key: key,
          builder: (s) => _MxcNonFormTextField.viewOnly(
            disabled: true,
            label: label,
            text: text,
            suffixButton: suffixButton,
            focusNode: focusNode,
            hint: hint,
            obscure: obscure,
            suffixText: suffixText,
            width: width,
          ),
        );

  MxcTextField.multiline({
    required Key? key,
    String? label,
    required TextEditingController this.controller,
    String? hint,
    FormFieldValidator<String>? validator,
    AutovalidateMode? autovalidateMode,
    TextInputAction? action,
  }) : super(
          key: key,
          initialValue: controller.text,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (field) {
            return _MxcNonFormTextField(
              key: null,
              label: label,
              controller: controller,
              hint: hint,
              obscure: false,
              readOnly: false,
              width: double.infinity,
              maxLines: 7,
              action: action,
              errorText: field.errorText,
            );
          },
        );

  MxcTextField.search({
    required Key? key,
    String? label,
    required TextEditingController this.controller,
    String? hint,
    double width = double.infinity,
    Color? backgroundColor,
    FormFieldValidator<String>? validator,
    AutovalidateMode? autovalidateMode,
    TextInputAction? action,
    ValueChanged<String>? onChanged,
    Widget? prefix,
  }) : super(
          key: key,
          initialValue: controller.text,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (field) {
            return _MxcNonFormTextField(
              key: null,
              label: label,
              controller: controller,
              hint: hint,
              obscure: false,
              readOnly: false,
              width: width,
              action: action,
              errorText: field.errorText,
              useAnimation: false,
              backgroundColor: backgroundColor,
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              onChanged: onChanged,
              prefix: prefix,
            );
          },
        );

  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() => MxcTextFieldFormState();
}

class MxcTextFieldFormState extends FormFieldState<String> {
  @override
  MxcTextField get widget => super.widget as MxcTextField;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.controller?.text;
    widget.controller?.addListener(_controllerListener);
  }

  String? _previousValue;
  void _controllerListener() {
    final newValue = widget.controller!.text;
    if (newValue != _previousValue) {
      setValue(widget.controller!.text);
      if (_previousValue != null) didChange(newValue);
      _previousValue = newValue;
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_controllerListener);
    super.dispose();
  }
}

class _MxcNonFormTextField extends StatefulWidget {
  const _MxcNonFormTextField({
    required Key? key,
    required this.label,
    required TextEditingController controller,
    this.hint,
    this.action,
    this.readOnly = false,
    this.suffixButton,
    this.width = double.infinity,
    this.maxLines = 1,
    this.focusNode,
    this.keyboardType,
    this.suffixText,
    this.obscure = false,
    this.errorText,
    this.followText,
    this.onChanged,
    this.useAnimation = true,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.borderRadius,
    this.prefix,
  })  : _controller = controller,
        _initialValue = null,
        disabled = false,
        super(key: key);

  const _MxcNonFormTextField.viewOnly({
    Key? key,
    required this.label,
    required String text,
    this.hint,
    this.action,
    this.suffixButton,
    this.width = double.infinity,
    this.focusNode,
    this.keyboardType,
    this.suffixText,
    this.obscure = false,
    this.disabled = false,
    this.followText,
    this.useAnimation = true,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.borderRadius,
    this.prefix,
  })  : _initialValue = text,
        readOnly = true,
        _controller = null,
        maxLines = 1,
        errorText = null,
        onChanged = null,
        super(key: key);

  final String? label;
  final bool readOnly;
  final String? hint;
  final TextInputAction? action;
  final TextInputType? keyboardType;
  final double width;
  final int maxLines;
  final FocusNode? focusNode;
  final MxcTextFieldButton? suffixButton;
  final String? suffixText;
  final bool disabled;

  final TextEditingController? _controller;
  final bool obscure;
  final String? _initialValue;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  final String? followText;

  final bool useAnimation;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  final Widget? prefix;

  @override
  State<_MxcNonFormTextField> createState() => _MxcNonFormTextFieldState();
}

class _MxcNonFormTextFieldState extends State<_MxcNonFormTextField> {
  late final FocusNode focusNode;
  late bool focused;
  TextEditingController? _internalController;

  double followPosition = 0;

  TextEditingController get controller {
    if (widget._controller != null) return widget._controller!;
    return _internalController ??=
        TextEditingController(text: widget._initialValue);
  }

  Size boundingTextSize(String text, TextStyle style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: text, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  Widget useAnimationContainer({
    bool useAnimation = true,
    Widget? child,
  }) {
    if (useAnimation) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            color: focused
                ? ColorsTheme.of(context).primaryText
                : ColorsTheme.of(context).primaryText.withOpacity(0.32),
          ),
        ),
        child: child,
      );
    }

    return Container(
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: child,
    );
  }

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    if (widget.disabled) {
      focused = false;
    } else {
      focused = focusNode.hasFocus;
      focusNode.addListener(_focusNodeListener);
    }

    controller.addListener(() {
      if (widget.followText != null) {
        Size textSize = boundingTextSize(
            controller.text, FontTheme.of(context, listen: false).body1());
        setState(() => followPosition = textSize.width);
      }
    });
  }

  void _focusNodeListener() {
    if (focusNode.hasFocus != focused) {
      setState(() => focused = focusNode.hasFocus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _internalController?.dispose();
    if (widget.focusNode == null) focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.label!,
                style: FontTheme.of(context).caption1(),
              ),
            ),
          useAnimationContainer(
            useAnimation: widget.useAnimation,
            child: Stack(
              children: [
                Row(
                  children: [
                    if (widget.prefix != null) widget.prefix!,
                    Expanded(
                      child: Scrollbar(
                        child: TextField(
                          readOnly: widget.readOnly,
                          keyboardType: widget.keyboardType,
                          focusNode: focusNode,
                          maxLines: widget.maxLines,
                          textInputAction: widget.action,
                          controller: controller,
                          cursorColor: ColorsTheme.of(context).primaryText,
                          style: (widget.disabled)
                              ? FontTheme.of(context).body1().copyWith(
                                    color:
                                        ColorsTheme.of(context).disabledButton,
                                  )
                              : FontTheme.of(context).body1(),
                          obscureText: widget.obscure,
                          onChanged: widget.onChanged,
                          decoration: InputDecoration(
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: widget.hint,
                            hintStyle:
                                FontTheme.of(context).subtitle1.secondary(),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    if (controller.text.isNotEmpty)
                      InkWell(
                        child: Icon(
                          Icons.cancel_rounded,
                          color: ColorsTheme.of(context).primaryButton,
                        ),
                        onTap: () {
                          controller.clear();
                          if (widget.onChanged != null) widget.onChanged!('');
                        },
                      ),
                    if (widget.suffixText != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          widget.suffixText!,
                          style: FontTheme.of(context).body1().copyWith(
                                color: ColorsTheme.of(context).grey1,
                              ),
                        ),
                      ),
                    if (widget.suffixButton != null)
                      MxcScopedTheme(
                        data: MxcScopedThemeData(
                          primaryColor: widget.disabled
                              ? ColorsTheme.of(context).disabledButton
                              : focused
                                  ? MxcScopedTheme.of(context).primaryColor
                                  : ColorsTheme.of(context).primaryText,
                        ),
                        child: widget.suffixButton!,
                      ),
                  ],
                ),
                if (widget.followText != null)
                  Positioned(
                    top: 8,
                    left: followPosition,
                    child: Text(
                      widget.followText!,
                      style: FontTheme.of(context).body1().copyWith(
                            color: Colors.white.withOpacity(0.32),
                          ),
                    ),
                  ),
              ],
            ),
          ),
          if (widget.errorText != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.error_rounded,
                  color: ColorsTheme.of(context).errorText,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    widget.errorText!,
                    style: FontTheme.of(context)
                        .subtitle1()
                        .copyWith(color: ColorsTheme.of(context).errorText),
                  ),
                )
              ],
            ),
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

abstract class MxcTextFieldButton extends StatelessWidget {
  const factory MxcTextFieldButton({
    Key? key,
    required Widget child,
    required VoidCallback? onTap,
    Color? color,
  }) = _MxcTextFieldButton;

  const MxcTextFieldButton._({
    Key? key,
    required this.onTap,
    this.color,
  }) : super(key: key);

  const factory MxcTextFieldButton.icon({
    Key? key,
    required IconData icon,
    required VoidCallback? onTap,
    Color? color,
    double? size,
  }) = _MxcTextFieldIconButton;

  const factory MxcTextFieldButton.image({
    Key? key,
    required ImageProvider image,
    required VoidCallback? onTap,
    Color? color,
  }) = _MxcTextFieldImageButton;

  const factory MxcTextFieldButton.svg({
    Key? key,
    required String svg,
    required VoidCallback? onTap,
    Color? color,
  }) = _MxcTextFieldSvgButton;

  const factory MxcTextFieldButton.text({
    Key? key,
    required String text,
    required VoidCallback? onTap,
    Color? color,
  }) = _MxcTextFieldSTextButton;

  final VoidCallback? onTap;
  final Color? color;

  Widget buildChild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: buildChild(context),
      ),
    );
  }
}

class _MxcTextFieldButton extends MxcTextFieldButton {
  const _MxcTextFieldButton({
    Key? key,
    required this.child,
    required VoidCallback? onTap,
    Color? color,
  }) : super._(key: key, onTap: onTap, color: color);

  final Widget child;

  @override
  Widget buildChild(BuildContext context) => child;
}

class _MxcTextFieldIconButton extends MxcTextFieldButton {
  const _MxcTextFieldIconButton({
    Key? key,
    required this.icon,
    required VoidCallback? onTap,
    this.size,
    Color? color,
  }) : super._(key: key, onTap: onTap, color: color);

  final IconData icon;
  final double? size;

  @override
  Widget buildChild(BuildContext context) => Icon(
        icon,
        size: size ?? 24,
        color: color ?? MxcScopedTheme.of(context).primaryColor,
      );
}

class _MxcTextFieldImageButton extends MxcTextFieldButton {
  const _MxcTextFieldImageButton({
    Key? key,
    required this.image,
    required VoidCallback? onTap,
    Color? color,
  }) : super._(key: key, onTap: onTap, color: color);

  final ImageProvider image;

  @override
  Widget buildChild(BuildContext context) => Image(
        image: image,
        width: 16,
        height: 16,
        color: color ?? MxcScopedTheme.of(context).primaryColor,
      );
}

class _MxcTextFieldSvgButton extends MxcTextFieldButton {
  const _MxcTextFieldSvgButton({
    Key? key,
    required this.svg,
    required VoidCallback? onTap,
    Color? color,
  }) : super._(key: key, onTap: onTap, color: color);

  final String svg;

  @override
  Widget buildChild(BuildContext context) => SvgPicture.asset(
        svg,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          color ?? MxcScopedTheme.of(context).primaryColor,
          BlendMode.srcIn,
        ),
      );
}

class _MxcTextFieldSTextButton extends MxcTextFieldButton {
  const _MxcTextFieldSTextButton({
    Key? key,
    required this.text,
    required VoidCallback? onTap,
    Color? color,
  }) : super._(key: key, onTap: onTap, color: color);

  final String text;

  @override
  Widget buildChild(BuildContext context) => Text(
        text,
        style: FontTheme.of(context).body2.primary().copyWith(
              color: color,
            ),
      );
}

class MxcMiniTextField extends FormField<String> {
  MxcMiniTextField({
    required Key? key,
    this.controller,
    this.onChanged,
    FormFieldValidator<String>? validator,
    bool disabled = false,
    bool error = false,
    FocusNode? focusNode,
    AutovalidateMode? autovalidateMode,
    EdgeInsets? scrollPadding,
  }) : super(
          key: key,
          initialValue: controller?.text,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (field) {
            return _MxcMiniNonFormTextField(
              key: null,
              controller: controller,
              onChanged: onChanged,
              focusNode: focusNode,
              disabled: disabled,
              scrollPadding: scrollPadding,
              error: field.errorText != null || error,
            );
          },
        );

  final TextEditingController? controller;
  final void Function(String)? onChanged;
}

class _MxcMiniNonFormTextField extends StatefulWidget {
  const _MxcMiniNonFormTextField({
    required Key? key,
    required this.controller,
    this.focusNode,
    this.disabled = false,
    this.error = false,
    this.onChanged,
    this.scrollPadding,
  }) : super(key: key);

  final FocusNode? focusNode;
  final bool disabled;
  final bool error;
  final EdgeInsets? scrollPadding;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  State<_MxcMiniNonFormTextField> createState() =>
      _MxcMiniNonFormTextFieldState();
}

class _MxcMiniNonFormTextFieldState extends State<_MxcMiniNonFormTextField> {
  late final FocusNode focusNode;
  late bool focused;
  TextEditingController? _internalController;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    if (widget.disabled) {
      focused = false;
    } else {
      focused = focusNode.hasFocus;
      focusNode.addListener(_focusNodeListener);
    }
  }

  void _focusNodeListener() {
    if (focusNode.hasFocus != focused && !widget.disabled) {
      setState(() => focused = focusNode.hasFocus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _internalController?.dispose();
    if (widget.focusNode == null) focusNode.dispose();
  }

  Color getColorBorder() {
    if (widget.disabled) {
      return ColorsTheme.of(context).disabledButton;
    }
    if (widget.error) return ColorsTheme.of(context).mainRed;
    if (_internalController != null && _internalController!.text.isEmpty) {
      return ColorsTheme.of(context).primaryBackground;
    }
    if (focused) return ColorsTheme.of(context).purpleMain;
    return ColorsTheme.of(context).secondaryText;
  }

  Color getColorFont() {
    if (widget.disabled) return ColorsTheme.of(context).fullRoundButton;
    if (widget.error) return ColorsTheme.of(context).mainRed;
    if (focused) return ColorsTheme.of(context).purpleMain;
    return ColorsTheme.of(context).primaryText;
  }

  bool isThickBorder() => (focused || widget.error);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(
        vertical: isThickBorder() ? 5 : 6,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border:
            Border.all(color: getColorBorder(), width: isThickBorder() ? 2 : 1),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: widget.controller,
        cursorColor: getColorFont(),
        readOnly: widget.disabled,
        style:
            FontTheme.of(context).subtitle1().copyWith(color: getColorFont()),
        textAlign: TextAlign.center,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4).copyWith(
            top: 4,
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        scrollPadding: const EdgeInsets.only(bottom: 100),
      ),
    );
  }
}
