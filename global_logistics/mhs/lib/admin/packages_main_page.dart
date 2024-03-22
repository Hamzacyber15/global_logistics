import 'package:flutter/material.dart';
import 'package:mhs/admin/add_package.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/models/package_model.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:provider/provider.dart';

class PackagesMainPage extends StatefulWidget {
  const PackagesMainPage({super.key});

  @override
  State<PackagesMainPage> createState() => _PackagesMainPageState();
}

class _PackagesMainPageState extends State<PackagesMainPage> {
  @override
  void initState() {
    super.initState();
    getPackages();
  }

  void getPackages() {
    Provider.of<StorageProvider>(context, listen: false).getPackages();
  }

  void addPackages() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const AddPackage();
    }));
  }

  void navOrder(PackageModel p) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddPackage(pm: p);
    }));
    addPackages();
  }

  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    List<PackageModel> package = Provider.of<StorageProvider>(context).packages;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Packages"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            for (int i = 0; i < package.length; i++)
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Transform.scale(
                      scale: 1.3,
                      child: Radio<int>(
                        value: i,
                        groupValue: selectedOption,
                        activeColor: AppTheme.greenColor,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                    title: Text(
                      package[i].packageTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(package[i].equipment),
                        Text(
                            "${"Price + Vat"} ${package[i].price.toString()} "),
                        Text(package[i].orderCategory),
                      ],
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: AppTheme.greyColor,
                      child: IconButton(
                          onPressed: () => navOrder(package[i]),
                          icon: const Icon(Icons.chevron_right)),
                    ),
                  ),
                ),
              ),
          ],
        ),
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
