import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/models/equipment_type_model.dart';

class PricingList extends StatelessWidget {
  final EquipmentTypeModel em;
  const PricingList({required this.em, super.key});

  @override
  Widget build(BuildContext context) {
    List<String> title = ["15 Minutes :", "30 Minutes :", "1 Hour :"];
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < title.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Column(
              children: [
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.orangeColor),
                  child: Center(
                      child: Text(
                    title[i],
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  )),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  i == 0
                      ? "${em.price.toString()} ${"OMR"} ${"+ Vat"}"
                      : i == 1
                          ? "${em.thiryMinutePrice.toString()} ${"OMR"} ${"+ Vat"}"
                          : "${em.sixtyMintesPrice.toString()} ${"OMR"} ${"+ Vat"}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
