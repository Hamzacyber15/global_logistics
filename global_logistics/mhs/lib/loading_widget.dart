import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator.adaptive(),
        SizedBox(
          height: 10,
        ),
        Text(
          "Loading...",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ));
  }
}
