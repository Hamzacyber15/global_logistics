import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/models/check_box_model.dart';

class CheckBoxContainer extends StatefulWidget {
  final CheckBoxModel cm;
  final Function parseData;
  final int index;
  const CheckBoxContainer(
      {required this.cm,
      required this.parseData,
      required this.index,
      super.key});

  @override
  State<CheckBoxContainer> createState() => _CheckBoxContainerState();
}

class _CheckBoxContainerState extends State<CheckBoxContainer> {
  FocusNode focusNode = FocusNode();
  TextEditingController titleController = TextEditingController();
  ValueNotifier<bool> check = ValueNotifier<bool>(false);

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

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        checkboxShape: const CircleBorder(),
        title: TextField(
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
