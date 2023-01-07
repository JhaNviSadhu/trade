import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:trade/binding/binding.dart';
import 'package:trade/network/api_provider.dart';
import 'package:trade/screens/home/home_screen.dart';
import 'package:trade/screens/login_screen.dart';
import 'package:trade/utils/color.dart';
import 'package:trade/utils/constant.dart';
import 'package:trade/utils/prefs.dart';
import 'package:trade/view/custom_button.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  OverlaySupportEntry? entry;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (entry != null) {
      entry?.dismiss();
    }

    if (result == ConnectivityResult.none) {
      // entry = showOverlayNotification((context) {
      //   return NetworkErrorAnimation();
      // }, duration: Duration(hours: 1));

      entry = showOverlay((context, _) {
        return const NetworkErrorAnimation();
      }, duration: const Duration(hours: 500000));
    }
  }

  void setupServiceLocator() {
    if (!sl.isRegistered<APIProvider>()) {
      sl.registerLazySingleton<APIProvider>(() => APIProvider());
    }
  }

  @override
  Widget build(BuildContext context) {
    setupServiceLocator();
    return OverlaySupport.global(
        child: GetMaterialApp(
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
    ));
  }
}

class NetworkErrorAnimation extends StatelessWidget {
  const NetworkErrorAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/json/no_internet_connection.json'),
            SizedBox(height: 50),
            Text(
              'Could not connect to the internet.\nPlease check your network.',
              maxLines: 3,
              style: Poppins.kTextStyle18Normal600,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
