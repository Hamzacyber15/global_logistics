import 'package:flutter/material.dart';
import 'package:mhs/widgets/check_box_container.dart';

class PlaceAnOrder extends StatefulWidget {
  const PlaceAnOrder({super.key});

  @override
  State<PlaceAnOrder> createState() => _PlaceAnOrderState();
}

class _PlaceAnOrderState extends State<PlaceAnOrder> {
  List<String> equipmentType = ["Tuk Tuk", "Fork Lift"];
  List<bool> equipmentTypeBool = [false, false];

  void changeStatus(int i) {
    setState(() {
      equipmentTypeBool[i] = !equipmentTypeBool[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place An Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (int i = 0; i < equipmentType.length; i++)
              Card(
                child: SizedBox(
                  height: 50,
                  child: CheckBoxContainer(
                      verticalPadding: 4,
                      check: equipmentTypeBool[i],
                      tapped: () => changeStatus(i),
                      showBorder: true,
                      title: equipmentType[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
