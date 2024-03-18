import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id;
  String delivery;
  String equipment;
  String pickUp;
  String indoorLocation;
  String indoorLocationId;
  String outdoorLocation;
  String outdoorBuilding;
  String outdoorlocationId;
  String block;
  Timestamp timestamp;
  OrderModel({
    required this.id,
    required this.delivery,
    required this.equipment,
    required this.pickUp,
    required this.indoorLocation,
    required this.indoorLocationId,
    required this.outdoorLocation,
    required this.outdoorBuilding,
    required this.outdoorlocationId,
    required this.block,
    required this.timestamp,
  });
}
