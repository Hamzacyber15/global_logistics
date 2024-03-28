import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/models/package_model.dart';
import 'package:mhs/order/order_now.dart';
import 'package:mhs/order/schedule_order.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:provider/provider.dart';

class PlaceAnOrder extends StatefulWidget {
  const PlaceAnOrder({super.key});

  @override
  State<PlaceAnOrder> createState() => _PlaceAnOrderState();
}

class _PlaceAnOrderState extends State<PlaceAnOrder> {
  int groupValueCount = 0;

  @override
  void initState() {
    super.initState();
    getPackages();
  }

  void getPackages() {
    Provider.of<StorageProvider>(context, listen: false).getPackages();
    Provider.of<StorageProvider>(context, listen: false).getEquipment("Indoor");
    Provider.of<StorageProvider>(context, listen: false)
        .getEquipment("Outdoor");
  }

  void changePage(Object count) {
    int i = count as int;
    setState(() {
      groupValueCount = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place An Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            CupertinoSlidingSegmentedControl(
              padding: const EdgeInsets.all(10),
              children: {
                0: Text(
                  "Order Now",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: groupValueCount == 0
                          ? AppTheme.blackColor
                          : AppTheme.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                1: Text(
                  "Schedule Order",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: groupValueCount == 1
                          ? AppTheme.blackColor
                          : AppTheme.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              },
              backgroundColor: AppTheme.primaryColor,
              groupValue: groupValueCount,
              onValueChanged: (index) {
                changePage(index!);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            groupValueCount == 0 ? const OrderNow() : const ScheduleOrder()
          ],
        ),
      ),
    );
  }
}
