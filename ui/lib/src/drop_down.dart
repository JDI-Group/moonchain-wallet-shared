import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';

class MXCDropDown<T> extends StatefulWidget {
  final List<T> itemList;
  final void Function(T?)? onChanged;
  final T selectedItem;
  final Widget? icon;
  final BorderRadius? borderRadius;
  final Widget? leadingIcon;
  const MXCDropDown({super.key, required this.itemList, required this.onChanged, required this.selectedItem, this.icon, this.borderRadius, this.leadingIcon});

  @override
  State<MXCDropDown<T>> createState() => _MXCDropDownState<T>();
}

class _MXCDropDownState<T> extends State<MXCDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: widget.selectedItem,
      icon: widget.icon ?? Container(),
      underline: Container(),
      focusColor: ColorsTheme.of(context).secondaryBackground,
      dropdownColor: ColorsTheme.of(context).secondaryBackground,
      elevation: 16,
      isDense: true,
      borderRadius: widget.borderRadius,
      style: TextStyle(color: ColorsTheme.of(context).primaryText),
      onChanged: widget.onChanged,
      items: widget.itemList  
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Row(
                  children: [
                    widget.leadingIcon??Container(),
                    Text(item.toString(), style: FontTheme.of(context).h7()),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
