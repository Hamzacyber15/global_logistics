import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentTypeModel {
  String id;
  String name;
  String status;
  String category;
  double price;
  EquipmentTypeModel({
    required this.id,
    required this.name,
    required this.status,
    required this.category,
    required this.price,
  });
  factory EquipmentTypeModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    EquipmentTypeModel em = EquipmentTypeModel(
        id: "", name: "", status: "", category: "", price: 0);
    em = EquipmentTypeModel(
        id: doc.id,
        name: data!['name'] ?? "",
        status: data['status'] ?? "",
        category: data['category'] ?? "",
        price: double.tryParse(data['price']) ?? 0);
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
