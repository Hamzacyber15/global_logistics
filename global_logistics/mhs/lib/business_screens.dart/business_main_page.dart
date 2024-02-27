import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/business_screens.dart/business_profile_screen.dart';
import 'package:mhs/models/business/business_profile.dart';
import 'package:mhs/widgets/build_segment.dart';

class BusinessMainPage extends StatefulWidget {
  final BusinessProfileModel cr;
  const BusinessMainPage({required this.cr, super.key});

  @override
  State<BusinessMainPage> createState() => _BusinessMainPageState();
}

class _BusinessMainPageState extends State<BusinessMainPage> {
  int groupValueCount = 0;

  void changeStatus(Object count) {
    int i = count as int;
    setState(() {
      groupValueCount = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cr.nameEnglish),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CupertinoSlidingSegmentedControl(
              padding: const EdgeInsets.all(6),
              children: const {
                0: BuildSegment(
                  "Business Profile",
                ),
                1: BuildSegment(
                  "Bookings",
                ),
              },
              backgroundColor: AppTheme.primaryColor.withOpacity(0.3),
              groupValue: groupValueCount,
              onValueChanged: (index) {
                changeStatus(index!);
              },
            ),
            groupValueCount == 0
                ? BusinessProfileScreen(cr: widget.cr)
                : BusinessProfileScreen(cr: widget.cr),
          ],
        ),
      ),
    );
  }
}
