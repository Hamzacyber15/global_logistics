import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/business/business_profile.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/models/storage_area_model.dart';
import 'package:mhs/order/confirm_order_details.dart';
import 'package:mhs/widgets/check_box_container.dart';
import 'package:mhs/widgets/custom_button.dart';
import 'package:mhs/widgets/drop_down_menu.dart';

class PlaceAnOrder extends StatefulWidget {
  const PlaceAnOrder({super.key});

  @override
  State<PlaceAnOrder> createState() => _PlaceAnOrderState();
}

class _PlaceAnOrderState extends State<PlaceAnOrder> {
  bool loading = false;
  List<String> equipmentType = ["Tuk Tuk", "Fork Lift"];
  String selectedBlock = "";
  List<StorageAreaModel> areaList = [];
  List<StorageAreaModel> dryStoreList = [];
  List<StorageAreaModel> onionStoreList = [];
  List<StorageAreaModel> potatoStoreList = [];
  List<DropDownMenuDataModel> area = [];
  List<DropDownMenuDataModel> dryStore = [];
  List<DropDownMenuDataModel> onionStore = [];
  List<DropDownMenuDataModel> potatoStore = [];
  DropDownMenuDataModel a = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel d = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel o = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel p = DropDownMenuDataModel("", "A-1", "A-1");
  DropDownMenuDataModel storage = Constants.coldStorageBlock[0];
  List<String> dropLocation = [
    "Cold Storage",
    "Dry Store",
    "Onion Shade",
    "Potato Shade"
  ];
  List<bool> dropLocationBool = [
    false,
    false,
    false,
    false,
  ];
  List<bool> equipmentTypeBool = [false, false];
  //BusinessProfileModel businessProfile =

  @override
  void initState() {
    super.initState();
  }

  void changeStatus(int i) {
    setState(() {
      equipmentTypeBool[i] = !equipmentTypeBool[i];
    });
  }

  void changeLocationStatus(int selectedIndex) {
    dropLocationBool[selectedIndex] = true;

    for (int i = 0; i < dropLocationBool.length; i++) {
      if (i != selectedIndex) {
        dropLocationBool[i] = false;
      }
    }
    if (dropLocationBool[1]) {
      getDryStore();
    } else if (dropLocationBool[2]) {
      getOnionStore();
    } else if (dropLocationBool[3]) {
      getPotatoStore();
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
    String selectedEquipment = "";
    if (equipmentTypeBool[0]) {
      //"Tuk Tuk", "Fork Lift"
      selectedEquipment = "Tuk Tuk";
    } else {
      selectedEquipment = "Fork Lift";
    }
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
    selectedBlock = value;
    getColdStorage();
  }

  void getColdStorage() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    setState(() {
      loading = true;
    });
    area.clear();
    try {
      await FirebaseFirestore.instance
          .collection('centralColdStorage')
          .where('block', isEqualTo: selectedBlock.toLowerCase())
          .get()
          .then((value) {
        for (var doc in value.docs) {
          StorageAreaModel? sm = StorageAreaModel.getStorageList(doc);
          if (sm != null) {
            areaList.add(sm);
            area.add(DropDownMenuDataModel(
                sm.id, sm.storage, "${"CDE-"}${sm.storage}"));
            a = area[0];
          }
          areaList.sort(
            (a, b) {
              return a.storage.toLowerCase().compareTo(b.storage.toLowerCase());
            },
          );
        }
      });
      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void getDryStore() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    setState(() {
      loading = true;
    });
    dryStore.clear();
    try {
      await FirebaseFirestore.instance
          .collection('dryStorage')
          .where('status', isEqualTo: "active")
          .get()
          .then((value) {
        for (var doc in value.docs) {
          StorageAreaModel? sm = StorageAreaModel.getStorageList(doc);
          if (sm != null) {
            dryStoreList.add(sm);
            dryStore
                .add(DropDownMenuDataModel(sm.id, sm.storage, "${sm.storage}"));
            d = dryStore[0];
          }
          areaList.sort(
            (a, b) {
              return a.storage.toLowerCase().compareTo(b.storage.toLowerCase());
            },
          );
        }
      });
      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void getOnionStore() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    setState(() {
      loading = true;
    });
    onionStore.clear();
    try {
      await FirebaseFirestore.instance
          .collection('onionShade')
          .where('status', isEqualTo: "active")
          .get()
          .then((value) {
        for (var doc in value.docs) {
          StorageAreaModel? sm = StorageAreaModel.getStorageList(doc);
          if (sm != null) {
            onionStoreList.add(sm);
            onionStore
                .add(DropDownMenuDataModel(sm.id, sm.storage, "${sm.storage}"));
            o = onionStore[0];
          }
          onionStoreList.sort(
            (a, b) {
              return a.storage.toLowerCase().compareTo(b.storage.toLowerCase());
            },
          );
        }
      });
      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void getPotatoStore() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    setState(() {
      loading = true;
    });
    onionStore.clear();
    try {
      await FirebaseFirestore.instance
          .collection('potatoShade')
          .where('status', isEqualTo: "active")
          .get()
          .then((value) {
        for (var doc in value.docs) {
          StorageAreaModel? sm = StorageAreaModel.getStorageList(doc);
          if (sm != null) {
            potatoStoreList.add(sm);
            potatoStore
                .add(DropDownMenuDataModel(sm.id, sm.storage, sm.storage));
            p = potatoStore[0];
          }
          potatoStoreList.sort(
            (a, b) {
              return a.storage.toLowerCase().compareTo(b.storage.toLowerCase());
            },
          );
        }
      });
      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void navConfirmOrder() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ConfirmOrderDetails();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place An Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < equipmentType.length; i++)
              Card(
                child: SizedBox(
                  height: 50,
                  child: CheckBoxContainer(
                      verticalPadding: 4,
                      check: equipmentTypeBool[i],
                      tapped: () => changeStatus(i),
                      showBorder: true,
                      title: equipmentType[i]),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: AppTheme.primaryColor),
            //   child: Text(
            //     "Select Unloading Location",
            //     style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: AppTheme.whiteColor),
            //   ),
            // ),
            Text(
              "Select Unloading Location",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor),
            ),
            const SizedBox(
              height: 5,
            ),
            for (int i = 0; i < dropLocation.length; i++)
              Card(
                child: SizedBox(
                  height: 50,
                  child: CheckBoxContainer(
                      verticalPadding: 4,
                      check: dropLocationBool[i],
                      tapped: () => changeLocationStatus(i),
                      showBorder: true,
                      title: dropLocation[i]),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            if (dropLocationBool[0])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Cold Storage Block",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                  Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: DropDownMenu(
                        getValues,
                        "Block",
                        const Icon(Icons.build),
                        Constants.coldStorageBlock,
                        storage,
                        "block"),
                  ),
                ],
              ),
            if (selectedBlock.isNotEmpty && dropLocationBool[0])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Cold Storage Area",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                  Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: DropDownMenu(getValues, "Cold Storgae",
                        const Icon(Icons.build), area, a, "cold storage"),
                  ),
                ],
              ),
            if (dropLocationBool[1])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Dry Store Area",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                  Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: DropDownMenu(getValues, "Dry Store",
                        const Icon(Icons.build), dryStore, d, "dry store"),
                  ),
                ],
              ),
            if (dropLocationBool[2])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Onion Store Area",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                  Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: DropDownMenu(getValues, "Onion Store",
                        const Icon(Icons.build), onionStore, o, "onion store"),
                  ),
                ],
              ),
            if (dropLocationBool[3])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Potato Store Area",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                  Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: DropDownMenu(
                        getValues,
                        "Potato Store",
                        const Icon(Icons.build),
                        potatoStore,
                        p,
                        "potato store"),
                  ),
                ],
              ),
          ],
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