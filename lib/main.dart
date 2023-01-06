import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:trade/binding/binding.dart';
import 'package:trade/network/api_provider.dart';
import 'package:trade/screens/home/home_screen.dart';
import 'package:trade/screens/login_screen.dart';
import 'package:trade/utils/color.dart';
import 'package:trade/utils/constant.dart';
import 'package:trade/utils/prefs.dart';

GetIt sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      var identifier = build.id;
      print(identifier); //UUID for Android
      Prefs.setString(kdeviceId, identifier);
      Prefs.setString(kdeviceType, 'android');
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      var identifier = data.identifierForVendor;
      print(identifier); //UUID for iOS
      Prefs.setString(kdeviceId, "$identifier");
      Prefs.setString(kdeviceType, 'ios');
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void setupServiceLocator() {
    if (!sl.isRegistered<APIProvider>()) {
      sl.registerLazySingleton<APIProvider>(() => APIProvider());
    }
  }

  @override
  Widget build(BuildContext context) {
    setupServiceLocator();
    return GetMaterialApp(
      initialBinding: TreadBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Trade',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: myPrimaryColor,
      ),
      home: (Prefs.getBool(kisLogin) ?? false)
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
