import 'package:flutter/material.dart';
import 'package:mxc_ui/mxc_ui.dart';

class MXCDropDown extends StatelessWidget {
  const MXCDropDown(
      {super.key,
      required this.onTap,
      required this.selectedItem,
      this.selectedItemHint});
  final Function onTap;
  final String selectedItem;
  final String? selectedItemHint;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsetsDirectional.only(
            top: Sizes.spaceSmall,
            bottom: Sizes.spaceSmall,
            end: Sizes.spaceSmall,
            start: Sizes.spaceNormal),
        decoration: BoxDecoration(
            color: ColorsTheme.of(context).screenBackground,
            border: Border.all(color: ColorsTheme.of(context).borderGrey3),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                selectedItem,
                style: FontTheme.of(context).body1.primary(),
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: Sizes.spaceXSmall,
            ),
            selectedItemHint != null
                ? Text(
                    selectedItemHint!,
                    style: FontTheme.of(context)
                        .body1()
                        .copyWith(color: ColorsTheme.of(context).textWhite100),
                  )
                : Container(),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding:
                    const EdgeInsetsDirectional.only(start: Sizes.spaceNormal),
                child: Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 24,
                  color: ColorsTheme.of(context).iconPrimary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
