import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/publicprofilemodel.dart';
import 'package:mhs/order/place_an_order.dart';
import 'package:mhs/registration/sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  void getData() async {
    await Hive.openBox("localMemory");
    final myBox = Hive.box("localMemory");
    User? user = FirebaseAuth.instance.currentUser;
    PublicProfileModel? profile =
        await PublicProfileModel.getPublicProfile(user!.uid);
    if (profile != null) {
      // BusinessProfileModelProfile? businessProfile =
      //     await BusinessProfileModelProfile.getPublicProfile(
      //         profile.businessId!);
      // businessProfile = Constants.businessProfile;
      profile = Constants.profile;
      myBox.put('profile', profile);
      //  myBox.put("businessProfile", businessProfile);
    }
  }

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

  void navOrder() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const PlaceAnOrder();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          // const Text("My Home Page"),
          // ElevatedButton(
          //   onPressed: logout,
          //   child: const Text(
          //     'Sign Out',
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navOrder,
        label: const Text("Place Order"),
        tooltip: 'Place Order',
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
