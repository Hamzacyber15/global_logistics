import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/business/business_area_model.dart';
import 'package:mhs/models/business/business_profile.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/models/storage_area_model.dart';
import 'package:mhs/order/confirm_order_details.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:mhs/widgets/business_area_list.dart';
import 'package:mhs/widgets/check_box_container.dart';
import 'package:mhs/widgets/drop_down_menu.dart';
import 'package:provider/provider.dart';

class PlaceAnOrder extends StatefulWidget {
  const PlaceAnOrder({super.key});

  @override
  State<PlaceAnOrder> createState() => _PlaceAnOrderState();
}

class _PlaceAnOrderState extends State<PlaceAnOrder> {
  bool loading = false;
  List<bool> orderCategoryBool = [true, false];
  List<String> orderCategory = ["Indoor Handling", "Outdoor"];
  BusinessAreaModel businessArea =
      BusinessAreaModel(title: "", value: "", id: "");
  String selectedBuildingCategory = "";
  // List<StorageAreaModel> areaList = [];
  // List<StorageAreaModel> dryStoreList = [];
  // List<StorageAreaModel> onionStoreList = [];
  // List<StorageAreaModel> potatoStoreList = [];
  // List<DropDownMenuDataModel> area = [];
  // List<DropDownMenuDataModel> dryStore = [];
  // List<DropDownMenuDataModel> onionStore = [];
  // List<DropDownMenuDataModel> potatoStore = [];
  DropDownMenuDataModel a = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel d = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel o = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel p = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel storage = Constants.coldStorageBlock[0];
  List<DropDownMenuDataModel> indoorList = [];
  List<String> orderCategoryImage = [
    'assets/images/indoor.png',
    'assets/images/outdoor.png'
  ];

  //BusinessProfileModel businessProfile =

  void changeStatus(String type, int i) {
    for (int j = 0; j < orderCategoryBool.length; j++) {
      if (j == i) {
        orderCategoryBool[j] = true;
      } else {
        orderCategoryBool[j] = false;
      }
    }

    setState(() {});
  }

  // void changeLocationStatus(int selectedIndex) {
  //   dropLocationBool[selectedIndex] = true;

  //   for (int i = 0; i < dropLocationBool.length; i++) {
  //     if (i != selectedIndex) {
  //       dropLocationBool[i] = false;
  //     }
  //   }
  //   if (dropLocationBool[1]) {
  //     getDryStore();
  //   } else if (dropLocationBool[2]) {
  //     getOnionStore();
  //   } else if (dropLocationBool[3]) {
  //     getPotatoStore();
  //   }
  //   setState(() {});
  // }

  void placeOrder() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    String selectedEquipment = "";
    // if (equipmentTypeBool[0]) {
    //   //"Tuk Tuk", "Fork Lift"
    //   selectedEquipment = "Tuk Tuk";
    // } else {
    //   selectedEquipment = "Fork Lift";
    // }
    setState(() {
      loading = true;
    });
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'businessId': Constants.businessId,
        'equipment': selectedEquipment,
        'storage': "coldStorage",
        "block": "e",
        "area": "CSE-30",
        "areaId": "",
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
    if (type == "selectBuilding") {
      selectedBuildingCategory = value;
      //indoorList.clear();
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
      }
    }
    setState(() {});
    //  getColdStorage();
  }

  void navConfirmOrder() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ConfirmOrderDetails();
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

  @override
  Widget build(BuildContext context) {
    final BusinessProfileModel business =
        Provider.of<StorageProvider>(context).business;
    // final List<DropDownMenuDataModel> wholeSale =
    //     Provider.of<StorageProvider>(context).wholeSaleArea;
    // final List<DropDownMenuDataModel> potatoShade =
    //     Provider.of<StorageProvider>(context).potatoArea;
    // final List<DropDownMenuDataModel> onionShade =
    //     Provider.of<StorageProvider>(context).onionArea;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place An Order"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              if (orderCategoryBool[0])
                Card(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  child: DropDownMenu(
                      getValues,
                      "Indoor Equipment",
                      //icon: indoorEquipmentIcons[0],
                      Constants.indoorEquipmentType,
                      storage,
                      "block"),
                ),
              if (orderCategoryBool[1])
                Card(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  child: DropDownMenu(
                      getValues,
                      "OutDoor Equipment",
                      // icon: outdoorEquipmentIcons[0],
                      Constants.outDoorEquipmentType,
                      storage,
                      "block"),
                ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppTheme.primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select loading Location",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.whiteColor),
                    ),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    if (businessArea.id.isNotEmpty)
                      Icon(
                        Icons.check_box,
                        color: AppTheme.whiteColor,
                      )
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              BusinessAreaList(
                bm: business.businessAreas,
                tapped: getData,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppTheme.primaryColor),
                child: Text(
                  "Select Unloading Location",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.whiteColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (orderCategoryBool[0] && indoorList.isNotEmpty)
                Card(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  child: DropDownMenu(
                      getValues,
                      "Select Building",
                      //  const Icon(Icons.build),
                      indoorList,
                      storage,
                      "selectBuilding"),
                ),
              if (orderCategoryBool[1])
                Card(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  child: DropDownMenu(
                      getValues,
                      "Select Building",
                      //  const Icon(Icons.build),
                      Constants.businessArea,
                      storage,
                      "selectBuilding"),
                ),
              if (orderCategoryBool[1] && indoorList.isNotEmpty)
                Card(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  child: DropDownMenu(
                      getValues,
                      "Select Building",
                      //  const Icon(Icons.build),
                      indoorList,
                      storage,
                      "selectBuilding"),
                ),
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: ElevatedButton(
          onPressed: navConfirmOrder, //count == 0 ? register : null,
          child: const Text(
            'Order Preview',
          ),
        ),
      ),
    );
  }
}
