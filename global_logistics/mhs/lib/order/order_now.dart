import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/business/business_area_model.dart';
import 'package:mhs/models/business/business_profile.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/models/order_model.dart';
import 'package:mhs/models/package_model.dart';
import 'package:mhs/order/confirm_order_details.dart';
import 'package:mhs/order/package_info.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:mhs/widgets/business_area_list.dart';
import 'package:mhs/widgets/check_box_container.dart';
import 'package:mhs/widgets/checkbox_listtile_container.dart';
import 'package:mhs/widgets/drop_down_menu.dart';
import 'package:provider/provider.dart';

class OrderNow extends StatefulWidget {
  const OrderNow({super.key});

  @override
  State<OrderNow> createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  bool loading = false;
  List<bool> orderCategoryBool = [false, false];
  bool packageTypeBool = false;
  List<String> orderCategory = ["Indoor Handling", "Outdoor Handling"];
  String packagetype = "Other Handling Package";
  int selectedOption = 0;
  BusinessAreaModel businessArea =
      BusinessAreaModel(title: "", value: "", id: "");
  OrderModel order = OrderModel(
      id: "",
      delivery: "",
      equipment: "",
      pickUp: "",
      indoorLocation: "",
      indoorLocationId: "",
      outdoorLocation: "",
      outdoorBuilding: "",
      outdoorlocationId: "",
      block: "",
      timestamp: Timestamp.now());
  // String selectedBuildingCategory = "";
  // String selectedEquipment = "";
  // String indoorLocation = "";
  // String indoorLocationId = "";
  // String outdoorBuilding = "";
  // String outdoorLocation = "";
  // String outdoorLocationId = "";
  // String deliveryType = "";
  DropDownMenuDataModel a = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel d = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel o = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel p = DropDownMenuDataModel("", "A-1", "A-1");
  List<DropDownMenuDataModel> indoorList = [];
  List<String> orderCategoryImage = [
    'assets/images/indoor.png',
    'assets/images/outdoor.png'
  ];

  //BusinessProfileModel businessProfile =

  void changeStatus(String type, int i) {
    if (type == "type") {
      for (int j = 0; j < orderCategoryBool.length; j++) {
        if (j == i) {
          orderCategoryBool[j] = true;
        } else {
          orderCategoryBool[j] = false;
        }
      }
    } else {
      packageTypeBool = !packageTypeBool;
      orderCategoryBool = List.filled(orderCategoryBool.length, false);
    }

    setState(() {});
  }

  void placeOrder() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    if (orderCategoryBool[0]) {
      //"Tuk Tuk", "Fork Lift"
      order.delivery = "Indoor Handling";
    } else {
      order.delivery = "Outdoor";
    }
    setState(() {
      loading = true;
    });
    dynamic pickUpLocation = 0;
    businessArea = pickUpLocation({
      'id': businessArea.id,
      'title': businessArea.title,
      'value': businessArea.value,
    });
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'businessId': Constants.businessId,
        'delivery': order.delivery,
        'equipment': order.equipment,
        'pickUp': pickUpLocation,
        'indoorLocation': order.indoorLocation,
        'indoorLocationId': order.indoorLocationId,
        'outdoorBuilding': order.outdoorBuilding,
        'outdoorLocation': order.outdoorLocation,
        'outdoorLocationId': order.outdoorlocationId,
        "block": "",
        "timestamp": FieldValue.serverTimestamp()
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void getValues(String type, String value, String id) {
    if (type == "outdoorBuilding") {
      order.outdoorBuilding = value;
      indoorList.clear();
      if (value == "Cold Storage Area") {
        indoorList = Provider.of<StorageProvider>(context, listen: false)
            .coldStorageArea;
      } else if (value == "Whole Sale Area") {
        indoorList =
            Provider.of<StorageProvider>(context, listen: false).wholeSaleArea;
      } else if (value == "Onion Area") {
        indoorList =
            Provider.of<StorageProvider>(context, listen: false).onionArea;
      } else if (value == "Potato Area") {
        indoorList =
            Provider.of<StorageProvider>(context, listen: false).potatoArea;
      } else if (value == "Parking Area (C)") {
        indoorList =
            Provider.of<StorageProvider>(context, listen: false).parkingAreaC;
      } else if (value == "Parking Area (A)") {
        indoorList =
            Provider.of<StorageProvider>(context, listen: false).parkingAreaA;
      }
    } else if (type == "equipment") {
      order.equipment = value;
    } else if (type == "indoorLocation") {
      order.indoorLocation == value;
      order.indoorLocationId == id;
    }
    // else if (type == "outdoorBuilding") {
    //   order.outdoorBuilding == value;
    // }
    else if (type == "outdoorLocation") {
      order.outdoorLocation == value;
      order.outdoorlocationId == id;
    }
    setState(() {});
    //  getColdStorage();
  }

  void checkCredentials() {
    bool result = false;
    if (orderCategoryBool[0]) {
      if (order.equipment.isEmpty) {
        Constants.showMessage(context, "Please Select Indoor Equipment");
      }
      return;
    } else if (orderCategoryBool[1]) {
      Constants.showMessage(context, "Please Select Outdoor Equipment");
      return;
    } else if (order.pickUp.isEmpty) {
      Constants.showMessage(context, "Please Select Pick Up Location");
      return;
    } else if (orderCategoryBool[0]) {
      if (order.indoorLocation.isEmpty) {
        Constants.showMessage(
            context, "Please Select Indoor Unloading/Handling Location");
        return;
      } else {
        result = true;
      }
    } else if (orderCategoryBool[1]) {
      if (order.outdoorBuilding.isEmpty) {
        Constants.showMessage(context, "Please Select Outdoor Building");
        return;
      } else if (order.outdoorLocation.isEmpty) {
        Constants.showMessage(
            context, "Please Select Outdoor Unloading Location");
        return;
      } else {
        result = true;
      }
    }
  }

  void navConfirmOrder() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ConfirmOrderDetails(om: order);
    }));
  }

  void getData(BusinessAreaModel bm) {
    businessArea = bm;
    if (orderCategoryBool[0]) {
      //  indoorList.clear();
      if (businessArea.value == "Onion Shade") {
        indoorList =
            Provider.of<StorageProvider>(context, listen: false).onionArea;
      } else if (businessArea.value == "Potato Shade") {
        indoorList =
            Provider.of<StorageProvider>(context, listen: false).potatoArea;
      } else if (businessArea.value == "Whole Sale") {
        indoorList =
            Provider.of<StorageProvider>(context, listen: false).wholeSaleArea;
      }
    }
    setState(() {});
  }

  // void getOrderInformation() {
  //   OrderModel om = OrderModel(id: "",
  //   delivery: delivery, equipment: equipment, pickUp: pickUp, indoorLocation: indoorLocation, indoorLocationId: indoorLocationId, outdoorLocation: outdoorLocation, outdoorBuilding: outdoorBuilding, outdoorlocationId: outdoorlocationId, block: block, timestamp: timestamp)
  // }

  void navOrder(PackageModel p) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return PackageInfo(pm: p);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final BusinessProfileModel business =
        Provider.of<StorageProvider>(context).business;
    List<PackageModel> package = Provider.of<StorageProvider>(context).packages;
    List<DropDownMenuDataModel> indoorEquipment =
        Provider.of<StorageProvider>(context).indoorEquipmentDropDown;
    List<DropDownMenuDataModel> outdoorEquipment =
        Provider.of<StorageProvider>(context).outdoorEquipmentDropDown;
    return Column(
      children: [
        if (!packageTypeBool)
          Row(
            children: [
              for (int i = 0; i < orderCategory.length; i++)
                Expanded(
                  child: Card(
                    child: CheckBoxContainer(
                        iconImage: orderCategoryImage[i],
                        check: orderCategoryBool[i],
                        tapped: () => changeStatus("type", i),
                        title: orderCategory[i]),
                  ),
                ),
            ],
          ),
        Row(
          children: [
            Expanded(
              child: Card(
                child: CheckBoxContainer(
                    iconImage: orderCategoryImage[0],
                    check: packageTypeBool,
                    tapped: () => changeStatus("packagetype", 0),
                    title: packagetype),
              ),
            ),
          ],
        ),
        if (packageTypeBool)
          for (int i = 0; i < package.length; i++)
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Transform.scale(
                    scale: 1.3,
                    child: Radio<int>(
                      value: i,
                      groupValue: selectedOption,
                      activeColor: AppTheme.greenColor,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  title: Text(
                    package[i].packageTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(package[i].equipment),
                      Text("${"Price + Vat"} ${package[i].price.toString()} "),
                      Text(package[i].orderCategory),
                    ],
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: AppTheme.greyColor,
                    child: IconButton(
                        onPressed: () => navOrder(package[i]),
                        icon: const Icon(Icons.chevron_right)),
                  ),
                ),
              ),
            ),
        // Card(
        //   child: CheckboxListTile(
        //     value: false,
        //     onChanged: (value) {},
        //     title: Text(package[i].packageTitle),
        //     subtitle: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(package[i].equipment),
        //         Text("${"Price + Vat"} ${package[i].price.toString()} "),
        //       ],
        //     ),
        //   ),
        // ),
        if (orderCategoryBool[0])
          Card(
            color: AppTheme.primaryColor.withOpacity(0.1),
            child: DropDownMenu(
                getValues,
                "Indoor Equipment",
                //icon: indoorEquipmentIcons[0],
                indoorEquipment,
                a,
                "equipment"),
          ),
        if (orderCategoryBool[1])
          Card(
            color: AppTheme.primaryColor.withOpacity(0.1),
            child: DropDownMenu(
                getValues,
                "OutDoor Equipment",
                // icon: outdoorEquipmentIcons[0],
                outdoorEquipment,
                a,
                "equipment"),
          ),
        const SizedBox(
          height: 20,
        ),
        // Text(
        //   "Select Indoor Handling Location",
        //   style: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //       color: AppTheme.blackColor),
        // ),
        Card(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.pallet,
                          color: AppTheme.blackColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (orderCategoryBool[1])
                          Text(
                            "Select Pick Up Location",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.blackColor),
                          ),
                        if (packageTypeBool)
                          Text(
                            "Select Package Handling Location",
                            //"Select Indoor Handling Location",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.blackColor),
                          ),
                      ],
                    ),

                    // const SizedBox(
                    //   width: 20,
                    // ),
                    if (businessArea.id.isNotEmpty)
                      Icon(
                        Icons.check_box,
                        color: AppTheme.whiteColor,
                      ),
                  ],
                ),
              ),
              const Divider(
                endIndent: 10,
                indent: 10,
                //color: AppTheme.blackColor,
              ),

              // Card(
              //   color: AppTheme.primaryColor.withOpacity(0.1),
              //   child: DropDownMenu(
              //       getValues,
              //       "Outdoor Equipment",
              //       // icon: outdoorEquipmentIcons[0],
              //       businessAreaList,
              //       storage,
              //       "businessAreaList"),
              // ),
              BusinessAreaList(
                bm: business.businessAreas,
                tapped: getData,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (orderCategoryBool[1] ||
            package[selectedOption].orderCategory.isNotEmpty &&
                package[selectedOption].orderCategory == "Outdoor")
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.whiteColor),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.pallet,
                      color: AppTheme.blackColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Select Unloading Location",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.blackColor),
                    ),
                  ],
                ),
                const Divider(
                  endIndent: 2,
                  indent: 2,
                  //color: AppTheme.blackColor,
                ),
                Card(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  child: DropDownMenu(
                      getValues,
                      "Select Building",
                      //  const Icon(Icons.build),
                      Constants.businessArea,
                      a,
                      "outdoorBuilding"),
                ),
                Card(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  child: DropDownMenu(
                      getValues,
                      "Select Warehouse",
                      //  const Icon(Icons.build),
                      indoorList,
                      a,
                      "outdoorLocation"),
                ),
              ],
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: navConfirmOrder,
          child: const Text("Preview Order"),
        ),
      ],
    );
  }
}
