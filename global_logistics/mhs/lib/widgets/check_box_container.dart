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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: CheckboxListTile(
          secondary: Icon(
            Icons.info,
            color: AppTheme.primaryColor,
          ),
          activeColor: AppTheme.greenColor,
          checkColor: AppTheme.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 6, vertical: verticalPadding!),
          visualDensity: VisualDensity.compact,
          dense: true,
          checkboxShape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              side: BorderSide(color: AppTheme.primaryColor)),
          value: check,
          onChanged: ((bool? value) {
            tapped();
          }),
          title: Text(
            title,
            maxLines: 2,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppTheme.blackColor),
          ),
        ),
      ),
    );
  }
}
