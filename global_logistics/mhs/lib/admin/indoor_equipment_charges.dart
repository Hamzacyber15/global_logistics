import 'package:flutter/material.dart';
import 'package:mhs/admin/add_equipment.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/models/equipment_type_model.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:mhs/widgets/pricing_list.dart';
import 'package:provider/provider.dart';

class IndoorEquipmentCharges extends StatefulWidget {
  const IndoorEquipmentCharges({super.key});

  @override
  State<IndoorEquipmentCharges> createState() => _IndoorEquipmentChargesState();
}

class _IndoorEquipmentChargesState extends State<IndoorEquipmentCharges> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getIndoorEquipment();
  }

  void getIndoorEquipment() {
    Provider.of<StorageProvider>(context, listen: false).getEquipment("Indoor");
  }

  void navAddEquipment(EquipmentTypeModel e) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddEquipment(et: e);
    }));
  }

  @override
  Widget build(BuildContext context) {
    List<EquipmentTypeModel> indoorEquipmentType =
        Provider.of<StorageProvider>(context).indoorEquipment;
    return Column(
      children: [
        for (int i = 0; i < indoorEquipmentType.length; i++)
          Column(
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    indoorEquipmentType[i].imageIcon,
                    height: 120,
                    width: 120,
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  indoorEquipmentType[i].name,
                  style: TextStyle(
                      color: AppTheme.blackColor, fontWeight: FontWeight.bold),
                ),
                subtitle: PricingList(em: indoorEquipmentType[i]),
                trailing: CircleAvatar(
                  backgroundColor: AppTheme.whiteColor,
                  child: IconButton(
                      onPressed: () => navAddEquipment(indoorEquipmentType[i]),
                      icon: const Icon(Icons.edit)),
                ),
              ),
              const Divider()
            ],
          ),
      ],
    );
  }
}
