import 'package:flutter/material.dart';
import '../app_theme.dart';

class DataTableWidget extends StatelessWidget {
  final List<String> titleList;
  final List<DataRow> rowElement;
  final double? rowHeight;
  const DataTableWidget(
      {required this.titleList,
      required this.rowElement,
      this.rowHeight = 30,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
        showCheckboxColumn: true,
        horizontalMargin: 30,
        columnSpacing: 30,
        headingRowHeight: 30,
        headingRowColor: MaterialStateProperty.all<Color?>(
            AppTheme.primaryColor.withOpacity(0.05)),
        dataRowMinHeight: 30,
        dataRowMaxHeight: rowHeight,
        dividerThickness: 1,
        columns: [
          for (int i = 0; i < titleList.length; i++)
            DataColumn(
              label: Text(
                titleList[i],
                style: TextStyle(
                    color: AppTheme.blackColor, fontWeight: FontWeight.bold),
              ),
            ),
        ],
        rows: rowElement);
  }
}
