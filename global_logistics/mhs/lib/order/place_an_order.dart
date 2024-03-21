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

            // Card(
            //   child: CheckBoxContainer(
            //     iconImage: 'assets/images/warehouse_building.png',
            //     check: false,
            //     tapped: () {},
            //     title: business.businessAreas[i].value,
            //     subtitleText: business.businessAreas[i].title,
            //   ),
            // )
            // for (int i = 0; i < dropLocation.length; i++)
            //   Card(
            //     child: SizedBox(
            //       height: 50,
            //       child: CheckBoxContainer(
            //           verticalPadding: 4,
            //           check: dropLocationBool[i],
            //           tapped: () => changeLocationStatus(i),
            //           showBorder: true,
            //           title: dropLocation[i]),
            //     ),
            //   ),
            // const SizedBox(
            //   height: 10,
            // ),
            // if (dropLocationBool[0])
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Select Cold Storage Block",
            //         style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: AppTheme.primaryColor),
            //       ),
            //       Card(
            //         color: AppTheme.primaryColor.withOpacity(0.1),
            //         child: DropDownMenu(
            //             getValues,
            //             "Block",
            //             //  const Icon(Icons.build),
            //             Constants.coldStorageBlock,
            //             storage,
            //             "block"),
            //       ),
            //     ],
            //   ),
            // if (selectedBlock.isNotEmpty && dropLocationBool[0])
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Select Cold Storage Area",
            //         style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: AppTheme.primaryColor),
            //       ),
            //       Card(
            //         color: AppTheme.primaryColor.withOpacity(0.1),
            //         child: DropDownMenu(
            //             getValues,
            //             "Cold Storgae",
            //             //const Icon(Icons.build),
            //             area,
            //             a,
            //             "cold storage"),
            //       ),
            //     ],
            //   ),
            // if (dropLocationBool[1])
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Select Dry Store Area",
            //         style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: AppTheme.primaryColor),
            //       ),
            //       Card(
            //         color: AppTheme.primaryColor.withOpacity(0.1),
            //         child: DropDownMenu(
            //             getValues,
            //             "Dry Store",
            //             //const Icon(Icons.build),
            //             dryStore,
            //             d,
            //             "dry store"),
            //       ),
            //     ],
            //   ),
            // if (dropLocationBool[2])
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Select Onion Store Area",
            //         style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: AppTheme.primaryColor),
            //       ),
            //       Card(
            //         color: AppTheme.primaryColor.withOpacity(0.1),
            //         child: DropDownMenu(
            //             getValues,
            //             "Onion Store",
            //             // const Icon(Icons.build),
            //             onionStore,
            //             o,
            //             "onion store"),
            //       ),
            //     ],
            //   ),
            // if (dropLocationBool[3])
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Select Potato Store Area",
            //         style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: AppTheme.primaryColor),
            //       ),
            //       Card(
            //         color: AppTheme.primaryColor.withOpacity(0.1),
            //         child: DropDownMenu(
            //             getValues,
            //             "Potato Store",
            //             // const Icon(Icons.build),
            //             potatoStore,
            //             p,
            //             "potato store"),
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
      //   child: ElevatedButton(
      //     onPressed: navConfirmOrder, //count == 0 ? register : null,
      //     child: const Text(
      //       'Order Preview',
      //     ),
      //   ),
      // ),
    );
  }
}
