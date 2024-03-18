import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/registration/sign_in.dart';

class AdminSideMenu extends StatefulWidget {
  final Function tapped;
  const AdminSideMenu({required this.tapped, super.key});

  @override
  State<AdminSideMenu> createState() => _AdminSideMenuState();
}

class _AdminSideMenuState extends State<AdminSideMenu> {
  void logout() async {
    FirebaseAuth.instance.signOut().then((value) async {
      // ignore: await_only_futures
      signOut();
    }).catchError((onError) {});
  }

  void signOut() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return const SignIn();
        },
      ),
    );
  }

  void adminNavigation(String type) {
    widget.tapped(type);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: AppTheme.primaryColor,
      child: ListView(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 70,
            width: 90,
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () => adminNavigation("adminDashboard"),
            leading: Icon(
              Icons.dashboard,
              color: AppTheme.whiteColor,
            ),
            title: Text(
              'Dashboard',
              style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.whiteColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1.2,
            indent: 10,
            endIndent: 20,
          ),
          ListTile(
            onTap: () => adminNavigation("employees"),
            leading: Icon(
              Icons.group,
              color: AppTheme.whiteColor,
            ),
            title: Text(
              'Employess',
              style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.whiteColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1.2,
            indent: 10,
            endIndent: 20,
          ),
          ListTile(
            onTap: () => adminNavigation("equipment"),
            leading: Icon(
              Icons.car_rental,
              color: AppTheme.whiteColor,
            ),
            title: Text(
              'Equipment',
              style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.whiteColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1.2,
            indent: 10,
            endIndent: 20,
          ),
          ListTile(
            onTap: () => adminNavigation("equipmentCharges"),
            leading: Icon(
              Icons.price_change,
              color: AppTheme.whiteColor,
            ),
            title: Text(
              'Equipment Details',
              style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.whiteColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1.2,
            indent: 10,
            endIndent: 20,
          ),
          ListTile(
            onTap: logout,
            leading: Icon(
              Icons.logout,
              color: AppTheme.whiteColor,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(color: AppTheme.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
