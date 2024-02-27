import 'package:flutter/material.dart';
import 'package:mhs/registration/cold_store_owner_registration.dart';
import 'package:mhs/widgets/custom_button.dart';

class UserType extends StatefulWidget {
  const UserType({super.key});

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  void navRegistration() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ColdStoreOwnerRegistration();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Select User Type",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              title: "Seller",
              tapped: navRegistration,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              title: "Custom Clearing Agent",
              tapped: () {},
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
