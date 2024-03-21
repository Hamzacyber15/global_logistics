import 'package:cloud_firestore/cloud_firestore.dart';

class PackageModel {
  String id;
  String packageTitle;
  String arabicPackageTitle;
  String description;
  String arabicDescription;
  int labour;
  double price;
  String containerSize;
  String estimatedDelivery;
  String orderCategory;
  String equipment;
  String equipmentId;
  PackageModel({
    required this.id,
    required this.packageTitle,
    required this.arabicPackageTitle,
    required this.description,
    required this.arabicDescription,
    required this.labour,
    required this.price,
    required this.containerSize,
    required this.estimatedDelivery,
    required this.orderCategory,
    required this.equipment,
    required this.equipmentId,
  });
  factory PackageModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    PackageModel pm = PackageModel(
        id: "",
        packageTitle: "",
        arabicPackageTitle: "",
        description: "",
        arabicDescription: "",
        labour: 0,
        price: 0,
        containerSize: "",
        estimatedDelivery: "",
        orderCategory: "",
        equipment: "",
        equipmentId: "");
    pm = PackageModel(
        id: doc.id,
        packageTitle: data!['packageTitle'] ?? "",
        arabicPackageTitle: data['arabicPackageTitle'] ?? "",
        description: data['description'] ?? "",
        arabicDescription: data['arabicDescription'] ?? "",
        labour: int.tryParse(data['labour'].toString()) ?? 0,
        price: double.tryParse(data['price'].toString()) ?? 0,
        containerSize: data['containerSize'] ?? "",
        estimatedDelivery: data['estimatedDelivery'] ?? "",
        orderCategory: data['orderCategory'] ?? "",
        equipment: data['equipment'] ?? "",
        equipmentId: data['equipmentId'] ?? "");
    return pm;
  }
  static PackageModel? getPackage(DocumentSnapshot<Map<String, dynamic>> d) {
    try {
      return PackageModel.fromMap(d);
    } catch (e) {
      return null;
    }
  }
}
