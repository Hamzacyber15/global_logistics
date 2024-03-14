import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/bottom_bar_screens.dart/home.dart';
import 'package:mhs/bottom_bar_screens.dart/profile.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile() {
    Provider.of<StorageProvider>(context, listen: false).getBusinessProfile();
    Provider.of<StorageProvider>(context, listen: false).getWholeSale();
    Provider.of<StorageProvider>(context, listen: false).getOnionArea();
    Provider.of<StorageProvider>(context, listen: false).getPotatoArea();
  }

  int index = 0;
  Widget getBody(int index) {
    // int providerIndex = context.read<ServicesProvider>().homeIndex;
    if (index == 0) {
      return const Home();
    } else if (index == 1) {
      return const //PlannedAdventure();
          Profile();
    } else {
      return const Center(
        child: Text('Body'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(index),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',

            //  ),
            activeIcon: Icon(
              Icons.home,
              color: AppTheme.primaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Profile',
            //  ),
            activeIcon: Icon(
              Icons.person,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
        backgroundColor: AppTheme.whiteColor,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.primaryColor.withOpacity(0.5),
        selectedLabelStyle: TextStyle(color: AppTheme.primaryColor),
        showUnselectedLabels: true,
      ),
    );
  }
}
