import 'package:flutter/material.dart';
import 'package:mhs/admin/add_package.dart';
import 'package:mhs/app_theme.dart';

class PackagesMainPage extends StatefulWidget {
  const PackagesMainPage({super.key});

  @override
  State<PackagesMainPage> createState() => _PackagesMainPageState();
}

class _PackagesMainPageState extends State<PackagesMainPage> {
  void addPackages() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const AddPackage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Packages"),
      ),
      body: const Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addPackages,
        label: const Text("Add Package"),
        tooltip: 'Add Package',
        elevation: 12,
        focusElevation: 5,
        splashColor: AppTheme.greenColor,
        backgroundColor: AppTheme.primaryColor,
        hoverColor: AppTheme.orangeColor,
        hoverElevation: 50,
        icon: Icon(
          Icons.add,
          color: AppTheme.whiteColor,
        ),
      ),
    );
  }
}
