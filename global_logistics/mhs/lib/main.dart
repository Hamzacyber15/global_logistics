import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/check_profile.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:mhs/registration/sign_in.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  //open the box
  await Hive.openBox("localMemory");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<StorageProvider>(
        create: (_) => StorageProvider(),
      )
    ],
    child: EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future getAppFuture;
  bool isDark = false;
  // This widget is the root of your application.
  @override
  void initState() {
    getAppFuture = getApp();
    super.initState();
  }

  Future<FirebaseApp> getApp() async {
    FirebaseApp initialization = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return initialization;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Global Logistics',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getCurrentTheme(isDark),
      home: FutureBuilder(
        future: getAppFuture,
        builder: (context, appSnapshot) {
          if (appSnapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.active) {
                    if (userSnapshot.hasData) {
                      return const CheckProfile();
                    } else {
                      return const SignIn();
                    }
                  } else {
                    return const Scaffold(body: Text("Testinng 2"));
                  }
                });
          } else {
            return const Scaffold(body: Text("Testinng 1"));
          }
        },
      ),
    );
  }
}
