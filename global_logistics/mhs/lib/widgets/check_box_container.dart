import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';

class CheckBoxContainer extends StatelessWidget {
  final bool check;
  final Function tapped;
  final String title;
  final bool? showBorder;
  final double? verticalPadding;
  const CheckBoxContainer(
      {required this.check,
      required this.tapped,
      required this.title,
      this.verticalPadding = 0,
      this.showBorder = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.primaryColor.withOpacity(0.1),
        border: !showBorder!
            ? Border.all(width: 1, color: AppTheme.blackColor.withOpacity(0.2))
            : null,
      ),
      child: CheckboxListTile(
        secondary: Icon(
          Icons.check_box,
          color: AppTheme.primaryColor,
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 10, vertical: verticalPadding!),
        visualDensity: VisualDensity.compact,
        dense: true,
        checkboxShape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            side: BorderSide(color: AppTheme.primaryColor)),
        value: check,
        onChanged: ((bool? value) {
          tapped();
          // setState(() {
          //   isFree = !isFree;
          // });
        }),
        title: Text(
          title,
          maxLines: 2,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppTheme.blackColor),
        ),
      ),
    );
  }
}
