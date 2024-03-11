import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mhs/admin/admin_main_page.dart';
import 'package:mhs/bottom_bar_screens.dart/bottom_nav_bar.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/loading_widget.dart';
import 'package:mhs/models/business_profile_model_profile.dart';
import 'package:mhs/models/publicprofilemodel.dart';

class CheckProfile extends StatefulWidget {
  const CheckProfile({super.key});

  @override
  State<CheckProfile> createState() => _CheckProfileState();
}

class _CheckProfileState extends State<CheckProfile> {
  bool loading = false;
  String role = "";

  @override
  void initState() {
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    // await Hive.openBox("localMemory");
    // final myBox = Hive.box("localMemory");
    PublicProfileModel? profile =
        await PublicProfileModel.getPublicProfile(user.uid);

    if (profile != null) {
      if (profile.role == "admin") {
        navAdmin();
      } else if (profile.role == "business") {
        profile.businessId = Constants.businessId;
        profile.id = Constants.profileId;
        // BusinessProfileModelProfile? businessProfile =
        //     await BusinessProfileModelProfile.getPublicProfile(
        //         profile.businessId!);
        // myBox.put('profile', profile);
        // myBox.put("businessProfile", businessProfile);
        navHome();
      }
    }
  }

  void navAdmin() {
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (_) {
          return const AdminMainPage();
        },
      ), (route) => false);
    }
  }

  void navHome() {
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (_) {
          return const BottomNavBar();
        },
      ), (route) => false);
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoadingWidget());
  }
}
