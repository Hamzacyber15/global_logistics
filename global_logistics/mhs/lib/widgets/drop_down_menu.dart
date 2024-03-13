import 'package:flutter/material.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import '../app_theme.dart';

class DropDownMenu extends StatefulWidget {
  final Function getValues;
  final String title;
  final String? icon;
  final List<DropDownMenuDataModel> list;
  final DropDownMenuDataModel initialValue;
  final String type;
  final bool? showBorder;
  const DropDownMenu(
      this.getValues, this.title, this.list, this.initialValue, this.type,
      {this.icon, this.showBorder = false, super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  bool isSelected = false;
  late DropDownMenuDataModel selected;

  @override
  void initState() {
    selected = widget.initialValue;
    super.initState();
  }

  List<PopupMenuEntry<DropDownMenuDataModel>> itemBuilder(
      BuildContext context) {
    return widget.list.map((e) {
      return PopupMenuItem(
        value: e,
        child: Row(
          children: [
            Image.asset(
              widget.icon!,
              height: 20,
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              e.title,
              style: const TextStyle(),
            ),
          ],
        ),
      );
    }).toList();
  }

  void select(DropDownMenuDataModel s) {
    setState(() {
      selected = s;
      isSelected = true;
    });
    widget.getValues(widget.type, selected.title, selected.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: widget.showBorder!
              ? Border.all(color: AppTheme.blackColor.withOpacity(0.05))
              : null,
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: PopupMenuButton(
          itemBuilder: itemBuilder,
          color: AppTheme.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          //offset: const Offset(40, 65),
          onSelected: (DropDownMenuDataModel result) => select(result),
          child: ListTile(
            visualDensity: VisualDensity.compact,
            minVerticalPadding: 0,
            dense: true,
            leading: widget.icon != null
                ? Image.asset(
                    widget.icon!,
                    height: 20,
                    width: 20,
                  )
                : null,
            title: isSelected
                ? Text(
                    selected.title,
                    maxLines: 1,
                    style: TextStyle(
                        color: AppTheme.blackColor,
                        fontWeight: FontWeight.w500),
                  )
                : Text(
                    widget.title,
                    maxLines: 1,
                    style: TextStyle(color: AppTheme.blackColor),
                  ),
            // subtitle: isSelected ? Text(selected.title) : const Text(''),
            trailing: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}
