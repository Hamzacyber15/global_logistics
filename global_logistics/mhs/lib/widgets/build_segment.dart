import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';

class BuildSegment extends StatelessWidget {
  final String titleText;
  const BuildSegment(this.titleText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppTheme.blackColor,
          fontSize: 14,
          fontWeight: FontWeight.w600),
    );
  }
}
