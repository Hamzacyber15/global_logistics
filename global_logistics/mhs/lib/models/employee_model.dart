import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  String id;
  List<String> attachments;
  String contactNumber;
  String designation;
  String idCardNumber;
  String name;
  String otherCompany;
  String status;
  Timestamp timestamp;
  String userId;
  bool globalEmployee;
  EmployeeModel({
    required this.id,
    required this.attachments,
    required this.contactNumber,
    required this.designation,
    required this.idCardNumber,
    required this.name,
    required this.otherCompany,
    required this.status,
    required this.timestamp,
    required this.userId,
    required this.globalEmployee,
  });

  factory EmployeeModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    EmployeeModel em = EmployeeModel(
        id: "",
        attachments: [],
        contactNumber: "",
        designation: "",
        idCardNumber: "",
        name: "",
        otherCompany: "",
        status: "",
        timestamp: Timestamp.now(),
        userId: "",
        globalEmployee: false);
    List<dynamic> a = data!['attachments'] ?? [];
    List<String> attachments = [];
    for (var element in a) {
      attachments.add(element);
    }
    em = EmployeeModel(
        id: doc.id,
        attachments: attachments,
        contactNumber: data['contactNumber'] ?? "",
        designation: data['designation'] ?? "",
        idCardNumber: data['idCardNumber'] ?? "",
        name: data['name'] ?? "",
        otherCompany: data['otherCompany'] ?? "",
        status: data['status'] ?? "",
        globalEmployee: data['globalEmployee'] ?? false,
        timestamp: data['timestamp'] ?? Timestamp.now(),
        userId: data['userId'] ?? "");
    return em;
  }

  static EmployeeModel? getBusinessList(
      DocumentSnapshot<Map<String, dynamic>> d) {
    try {
      return EmployeeModel.fromMap(d);
    } catch (e) {
      return null;
    }
  }
}
