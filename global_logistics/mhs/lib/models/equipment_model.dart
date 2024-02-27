import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentModel {
  String id;
  String equipmentBrand;
  String equipmentCapacity;
  String equipmentDriverId;
  String equipmentType;
  String status;
  Timestamp timestamp;
  EquipmentModel({
    required this.id,
    required this.equipmentBrand,
    required this.equipmentCapacity,
    required this.equipmentDriverId,
    required this.equipmentType,
    required this.status,
    required this.timestamp,
  });
  factory EquipmentModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    EquipmentModel em = EquipmentModel(
        id: "",
        equipmentBrand: "",
        equipmentCapacity: "",
        equipmentDriverId: "",
        equipmentType: "",
        status: "",
        timestamp: Timestamp.now());
    em = EquipmentModel(
        id: doc.id,
        equipmentBrand: data!["equipmentBrand"] ?? "",
        equipmentCapacity: data["equipmentCapacity"] ?? "",
        equipmentDriverId: data["equipmentDriverId"] ?? "",
        equipmentType: data["equipmentType"] ?? "",
        status: data["status"] ?? "",
        timestamp: data["timestamp"] ?? Timestamp.now());
    return em;
  }
  static EquipmentModel? getBusinessList(
      DocumentSnapshot<Map<String, dynamic>> d) {
    try {
      return EquipmentModel.fromMap(d);
    } catch (e) {
      return null;
    }
  }
}
