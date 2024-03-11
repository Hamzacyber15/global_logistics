import 'package:cloud_firestore/cloud_firestore.dart';

class StorageAreaModel {
  String id;
  String? block;
  String storage;
  String status;
  StorageAreaModel({
    required this.id,
    this.block,
    required this.storage,
    required this.status,
  });
  factory StorageAreaModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    StorageAreaModel sm =
        StorageAreaModel(id: "", block: "", storage: "", status: "");
    sm = StorageAreaModel(
        id: doc.id,
        block: data!['block'] ?? "",
        storage: data['storage'] ?? "",
        status: data['status'] ?? "");
    return sm;
  }
  static StorageAreaModel? getStorageList(
      DocumentSnapshot<Map<String, dynamic>> d) {
    try {
      return StorageAreaModel.fromMap(d);
    } catch (e) {
      return null;
    }
  }
}
