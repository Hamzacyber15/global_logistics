import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/business/business_profile.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/models/equipment_type_model.dart';
import 'package:mhs/models/package_model.dart';
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
  List<DropDownMenuDataModel> indoorEquipmentDropDown = [];
  List<DropDownMenuDataModel> outdoorEquipmentDropDown = [];
  List<StorageAreaModel> parkingAreaListA = [];
  List<DropDownMenuDataModel> parkingAreaA = [];
  List<StorageAreaModel> parkingAreaListC = [];
  List<DropDownMenuDataModel> parkingAreaC = [];
  List<PackageModel> packages = [];
  String selectedBlock = "";
  List<DropDownMenuDataModel> businessAreaList = [];
  BusinessProfileModel business = BusinessProfileModel(
      id: "",
      businessAddress: "",
      businessAreas: [],
      certificate: [],
      nameArabic: "",
      nameEnglish: "",
      phoneNumber: "",
      registrationNum: "",
      status: "",
      userCountry: "",
      userEmail: "",
      userId: "",
      userLanguage: "",
      userMobile: "",
      userName: "",
      userAttachment: []);
  List<EquipmentTypeModel> indoorEquipment = [];
  List<EquipmentTypeModel> outdoorEquipment = [];

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

  void getBusinessProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      await FirebaseFirestore.instance
          .collection('business')
          .where('userId', isEqualTo: user.uid)
          .get()
          .then((value) {
        for (var doc in value.docs) {
          BusinessProfileModel? bp = BusinessProfileModel.getBusinessList(doc);
          if (bp != null) {
            business = bp;
            Constants.businessId = business.id;
          }
        }
        for (var element in business.businessAreas) {
          businessAreaList.add(
              DropDownMenuDataModel(element.id, element.title, element.value));
        }
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
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
    potatoList.clear();
    potatoArea.clear();
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

  void getParkingArea(String block) async {
    if (block == "a") {
      parkingAreaListA.clear();
      parkingAreaA.clear();
    } else {
      parkingAreaListC.clear();
      parkingAreaC.clear();
    }
    try {
      await FirebaseFirestore.instance
          .collection('parking')
          .where('block', isEqualTo: block)
          .where('status', isEqualTo: "active")
          .get()
          .then((value) {
        for (var doc in value.docs) {
          StorageAreaModel sm = StorageAreaModel(
              id: doc.id,
              block: doc.data()['block'] ?? "",
              storage: doc.data()['parking'] ?? "",
              status: doc.data()['status'] ?? "");
          if (block == "a") {
            parkingAreaListA.add(sm);
            parkingAreaA
                .add(DropDownMenuDataModel(sm.id, sm.storage, sm.storage));
          } else {
            parkingAreaListC.add(sm);
            parkingAreaC
                .add(DropDownMenuDataModel(sm.id, sm.storage, sm.storage));
          }
        }
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void getEquipment(String type) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      await FirebaseFirestore.instance
          .collection('equipmentCategory')
          .where('equipmentCategory', isEqualTo: type)
          .where('status', isEqualTo: "active")
          .get()
          .then((value) {
        if (type == "Indoor") {
          indoorEquipment.clear();
        } else {
          outdoorEquipment.clear();
        }
        indoorEquipment.clear();
        outdoorEquipment.clear();
        for (var doc in value.docs) {
          EquipmentTypeModel? em = EquipmentTypeModel.getEquipment(doc);
          if (em != null) {
            if (type == "Indoor") {
              indoorEquipment.add(em);
              indoorEquipmentDropDown.add(DropDownMenuDataModel(
                  em.id, em.name, em.name,
                  image: em.imageIcon));
            } else {
              outdoorEquipment.add(em);
              outdoorEquipmentDropDown.add(DropDownMenuDataModel(
                  em.id, em.name, em.name,
                  image: em.imageIcon));
            }
          }
        }
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getPackages() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      await FirebaseFirestore.instance
          .collection('packages')
          .where('status', isEqualTo: "active")
          .get()
          .then((value) {
        packages.clear();
        for (var doc in value.docs) {
          PackageModel? pm = PackageModel.getPackage(doc);
          if (pm != null) {
            packages.add(pm);
          }
        }
        notifyListeners();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
