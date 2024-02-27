import 'dart:math';

import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final Widget child;
  const SideBar({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Container(
          color: Colors.white,
          width: min(620, MediaQuery.of(context).size.width * 0.5),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
