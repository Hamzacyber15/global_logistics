import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentTypeModel {
  String id;
  String name;
  String status;
  String category;
  String imageIcon;
  double price;
  double? thiryMinutePrice;
  double? sixtyMintesPrice;
  EquipmentTypeModel({
    required this.id,
    required this.name,
    required this.status,
    required this.category,
    required this.price,
    required this.imageIcon,
    this.thiryMinutePrice,
    this.sixtyMintesPrice,
  });
  factory EquipmentTypeModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    EquipmentTypeModel em = EquipmentTypeModel(
        id: "", name: "", status: "", category: "", price: 0, imageIcon: "");
    em = EquipmentTypeModel(
        id: doc.id,
        name: data!['equipmentTitle'] ?? "",
        status: data['status'] ?? "",
        category: data['equipmentCategory'] ?? "",
        imageIcon: data['equipmentIcon'] ?? "",
        price: double.tryParse(data['price'].toString()) ?? 0,
        thiryMinutePrice:
            double.tryParse(data['thirtyMinutePrice'].toString()) ?? 0,
        sixtyMintesPrice:
            double.tryParse(data['sixtyMinutesPrice'].toString()) ?? 0);

    return em;
  }
  static EquipmentTypeModel? getEquipment(
      DocumentSnapshot<Map<String, dynamic>> d) {
    try {
      return EquipmentTypeModel.fromMap(d);
    } catch (e) {
      return null;
    }
  }
}
