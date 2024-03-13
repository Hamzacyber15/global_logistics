import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/models/storage_area_model.dart';

class StorageProvider with ChangeNotifier {
  List<StorageAreaModel> coldStorageAreaList = [];
  List<DropDownMenuDataModel> coldStorageArea = [];
  List<DropDownMenuDataModel> wholeSaleArea = [];
  List<StorageAreaModel> wholeSaleList = [];
  List<DropDownMenuDataModel> onionArea = [];
  List<StorageAreaModel> onionList = [];
  List<DropDownMenuDataModel> potatoArea = [];
  List<StorageAreaModel> potatoList = [];
  List<DropDownMenuDataModel> sellFromTruckArea = [];
  List<StorageAreaModel> sellFromTruckList = [];
  String selectedBlock = "";

  void getColdStorageBlock(String block) {
    selectedBlock = block;
    getColdStorage();
  }

  void getWholeSaleArea(String area) {
    if (area == "wholeSale") {
      getWholeSale();
    } else if (area == "onionShade") {
      getOnionArea();
    } else if (area == "potatoShade") {
      getPotatoArea();
    }
  }

  void getColdStorage() async {
    coldStorageArea.clear();
    try {
      await FirebaseFirestore.instance
          .collection('centralColdStorage')
          .where('block', isEqualTo: selectedBlock.toLowerCase()) //)
          .get()
          .then((value) {
        for (var doc in value.docs) {
          StorageAreaModel? sm = StorageAreaModel.getStorageList(doc);
          if (sm != null) {
            coldStorageAreaList.add(sm);
            coldStorageArea.add(DropDownMenuDataModel(
                sm.id, sm.storage, "${"CDE-"}${sm.storage}"));
          }
        }
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void getWholeSale() async {
    coldStorageArea.clear();
    try {
      await FirebaseFirestore.instance
          .collection('wholesaleArea')
          .where('status', isEqualTo: "active") //)
          .get()
          .then((value) {
        for (var doc in value.docs) {
          //  StorageAreaModel? sm = StorageAreaModel.getStorageList(doc);
          StorageAreaModel sm = StorageAreaModel(
              id: doc.id,
              block: doc.data()['block'] ?? "",
              storage: doc.data()['area'] ?? "",
              status: doc.data()['status'] ?? "");

          wholeSaleList.add(sm);
          wholeSaleArea
              .add(DropDownMenuDataModel(sm.id, sm.storage, sm.storage));
        }
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void getOnionArea() async {
    coldStorageArea.clear();
    try {
      await FirebaseFirestore.instance
          .collection('onionShade')
          .where('status', isEqualTo: "active") //)
          .get()
          .then((value) {
        for (var doc in value.docs) {
          StorageAreaModel? sm = StorageAreaModel.getStorageList(doc);
          if (sm != null) {
            onionList.add(sm);
            onionArea.add(DropDownMenuDataModel(sm.id, sm.storage, sm.storage));
          }
        }
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void getPotatoArea() async {
    coldStorageArea.clear();
    try {
      await FirebaseFirestore.instance
          .collection('potatoShade')
          .where('status', isEqualTo: "active") //)
          .get()
          .then((value) {
        for (var doc in value.docs) {
          StorageAreaModel? sm = StorageAreaModel.getStorageList(doc);
          if (sm != null) {
            potatoList.add(sm);
            potatoArea
                .add(DropDownMenuDataModel(sm.id, sm.storage, sm.storage));
          }
        }
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }
}
