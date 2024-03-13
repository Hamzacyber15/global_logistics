import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/check_box_model.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/widgets/drop_down_menu.dart';

class CheckBoxListTileContainer extends StatefulWidget {
  final CheckBoxModel cm;
  final Function parseData;
  final int index;
  const CheckBoxListTileContainer(
      {required this.cm,
      required this.parseData,
      required this.index,
      super.key});

  @override
  State<CheckBoxListTileContainer> createState() =>
      _CheckBoxListTileContainerState();
}

class _CheckBoxListTileContainerState extends State<CheckBoxListTileContainer> {
  FocusNode focusNode = FocusNode();
  TextEditingController titleController = TextEditingController();
  ValueNotifier<bool> check = ValueNotifier<bool>(false);
  DropDownMenuDataModel storage = Constants.coldStorageBlock[0];

  @override
  void initState() {
    check.addListener(() {
      if (check.value) {
        focusNode.requestFocus();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void sendData() {
    widget.parseData(
        CheckBoxModel(
          title: widget.cm.title.trim(),
          status: check.value,
          value: titleController.text.trim(),
        ),
        widget.index);
  }

  void getValues(String type, String value, String id) {
    // selectedBlock = value;
    //  getColdStorage();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        checkboxShape: const CircleBorder(),
        title: //Text("data"),
            // check.value
            //     ? Card(
            //         color: AppTheme.primaryColor.withOpacity(0.1),
            //         child: DropDownMenu(
            //             getValues,
            //             "Block",
            //             const Icon(Icons.build),
            //             Constants.coldStorageBlock,
            //             storage,
            //             "block"),
            //       )
            //     : null,
            TextField(
          controller: titleController,
          focusNode: focusNode,
          onChanged: (value) {
            //widget.cm.value = value;
            sendData();
          },
          enabled: check.value,
          //controller: wholeSale,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              prefixIcon: check.value
                  ? const Icon(
                      Icons.text_fields,
                      color: Colors.black,
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              labelText: widget.cm.title,
              labelStyle: TextStyle(
                  fontWeight: check.value ? FontWeight.bold : FontWeight.w500,
                  color: widget.cm.status
                      ? AppTheme.greenColor
                      : AppTheme.blackColor.withOpacity(0.5))),
          cursorColor: AppTheme.primaryColor,
          textInputAction: TextInputAction.next,
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
        ),
        value: check.value,
        onChanged: (value) {
          setState(() {
            check.value = !check.value;
          });
          if (check.value) {
            focusNode.requestFocus();
          }
          sendData();
        });
  }
}
