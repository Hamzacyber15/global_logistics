import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback tapped;
  final bool? border;
  const CustomButton(
      {required this.title,
      required this.tapped,
      this.border = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: tapped,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: AppTheme.primaryColor,
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: AppTheme.whiteColor, fontSize: 16),
        ),
      ),
    );
  }
}
