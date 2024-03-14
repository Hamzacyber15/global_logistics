import 'package:flutter/material.dart';
import 'package:mhs/models/business/business_area_model.dart';
import 'package:mhs/widgets/check_box_container.dart';

class BusinessAreaList extends StatefulWidget {
  final List<BusinessAreaModel> bm;
  final Function tapped;
  const BusinessAreaList({required this.bm, required this.tapped, super.key});

  @override
  State<BusinessAreaList> createState() => _BusinessAreaListState();
}

class _BusinessAreaListState extends State<BusinessAreaList> {
  List<bool> check = [];

  @override
  void initState() {
    for (var element in widget.bm) {
      check.add(false);
    }
    super.initState();
  }

  void changeStatus(int i) {
    for (int j = 0; j < widget.bm.length; j++) {
      if (j == i) {
        check[j] = true;
      } else {
        check[j] = false;
      }
    }

    sendData();
  }

  void sendData() {
    for (int i = 0; i < check.length; i++) {
      if (check[i]) {
        widget.tapped(widget.bm[i]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.bm.length; i++)
          Card(
            child: CheckBoxContainer(
              iconImage: 'assets/images/warehouse_building.png',
              check: check[i],
              tapped: () => changeStatus(i),
              title: widget.bm[i].value,
              subtitleText: widget.bm[i].title,
            ),
          ),
      ],
    );
  }
}
