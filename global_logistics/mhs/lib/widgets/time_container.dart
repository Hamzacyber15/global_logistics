import 'package:flutter/material.dart';

import '../app_theme.dart';

class TimeContainer extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  const TimeContainer(
      {required this.titleText, required this.subtitleText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: 60,
      //width: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.whiteColor,
        border:
            Border.all(width: 1, color: AppTheme.blackColor.withOpacity(0.2)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        title: Text(
          //"Time : ",
          "$titleText ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        subtitle: Text(subtitleText),
        trailing: Icon(
          Icons.lock_clock_sharp,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
