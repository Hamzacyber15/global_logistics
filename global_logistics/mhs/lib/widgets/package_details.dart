import 'package:flutter/material.dart';
import 'package:mhs/models/package_model.dart';

class PackageDetails extends StatefulWidget {
  final PackageModel pm;
  const PackageDetails({required this.pm, super.key});

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.pm.packageTitle),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.pm.equipment),
              Text("${"Price + Vat"} ${widget.pm.price.toString()} "),
            ],
          ),
          trailing: IconButton(
              onPressed: () {}, icon: const Icon(Icons.chevron_right)),
        ),
      ],
    );
  }
}
