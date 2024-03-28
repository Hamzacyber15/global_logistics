import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/models/drop_down_menu_model.dart';

class WarehouseList extends StatefulWidget {
  final List<DropDownMenuDataModel> list;
  const WarehouseList({required this.list, super.key});

  @override
  State<WarehouseList> createState() => _WarehouseListState();
}

class _WarehouseListState extends State<WarehouseList> {
  TextEditingController searchController = TextEditingController();
  List<DropDownMenuDataModel> filteredList = [];

  @override
  void initState() {
    filteredList = widget.list;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void selectValue(DropDownMenuDataModel item) {
    /// widget.tapped(item);
    Navigator.of(context).pop(item);
  }

  void searchServices(String x) {
    if (x.isNotEmpty) {
      if (x.contains(RegExp(r'^\d+$'))) {
        // If the input contains only digits, search for matches with numbers only
        filteredList =
            widget.list.where((element) => element.value.contains(x)).toList();
      } else {
        // Otherwise, search for matches as usual
        filteredList = widget.list
            .where((element) => element.value.toLowerCase().contains(x))
            .toList();
      }
    } else {
      filteredList = widget.list;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Card(
              color: AppTheme.whiteColor,
              child: TextField(
                onChanged: (value) {
                  searchServices(value);
                },
                controller: searchController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  labelText: "Search",
                ),
                cursorColor: AppTheme.primaryColor,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
            for (int i = 0; i < filteredList.length; i++)
              Card(
                child: ListTile(
                  onTap: () => selectValue(filteredList[i]),
                  title: Text(filteredList[i].value),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
