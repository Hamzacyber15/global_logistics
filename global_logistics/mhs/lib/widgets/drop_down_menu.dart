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
  final int? index;
  const DropDownMenu(
      this.getValues, this.title, this.list, this.initialValue, this.type,
      {this.icon, this.showBorder = false, this.index, super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  bool isSelected = false;
  late DropDownMenuDataModel selected;
  List<DropDownMenuDataModel> list = [];

  @override
  void initState() {
    selected = widget.initialValue;
    list = widget.list;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DropDownMenu oldWidget) {
    if (oldWidget.list != widget.list) {
      list = widget.list;
      selected = widget.initialValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  List<PopupMenuEntry<DropDownMenuDataModel>> itemBuilder(
      BuildContext context) {
    return list.map((e) {
      return PopupMenuItem(
        value: e,
        child: Row(
          children: [
            if (widget.icon != null)
              Image.asset(
                widget.icon!,
                height: 25,
                width: 25,
              ),
            if (e.image != null)
              Image.network(
                e.image!,
                height: 35,
                width: 35,
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
    if (widget.index != null) {
      widget.getValues(widget.type, selected.title, selected.id, widget.index);
    } else {
      widget.getValues(widget.type, selected.title, selected.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: widget.showBorder!
              ? Border.all(color: AppTheme.blackColor.withOpacity(0.2))
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
                    height: 25,
                    width: 25,
                  )
                : selected.image != null
                    ? Image.network(
                        selected.image!,
                        height: 35,
                        width: 35,
                      )
                    : null,
            title: isSelected
                ? Text(
                    selected.title,
                    maxLines: 1,
                    style: TextStyle(
                        color: AppTheme.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )
                : Text(
                    widget.title,
                    maxLines: 1,
                    style: TextStyle(color: AppTheme.blackColor, fontSize: 14),
                  ),
            // subtitle: isSelected ? Text(selected.title) : const Text(''),
            trailing: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}
