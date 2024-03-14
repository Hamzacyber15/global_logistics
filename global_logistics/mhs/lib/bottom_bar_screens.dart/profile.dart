import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/business_profile_model_profile.dart';
import 'package:mhs/models/publicprofilemodel.dart';
import 'package:mhs/order/place_an_order.dart';
import 'package:mhs/registration/sign_in.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    //getData();
  }

  void getData() async {
    await Hive.openBox("localMemory");
    final myBox = Hive.box("localMemory");
    User? user = FirebaseAuth.instance.currentUser;
    PublicProfileModel? profile =
        await PublicProfileModel.getPublicProfile(user!.uid);
    if (profile != null) {
      BusinessProfileModelProfile? businessProfile =
          await BusinessProfileModelProfile.getPublicProfile(
              profile.businessId!);
      businessProfile = Constants.businessProfile;
      profile = Constants.profile;
      myBox.put('profile', profile);
      myBox.put("businessProfile", businessProfile);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text("My Home Page"),
          ElevatedButton(
            onPressed: logout,
            child: const Text(
              'Sign Out',
            ),
          ),
        ],
      ),
    );
  }
}
