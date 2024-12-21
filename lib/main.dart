import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/feature/nav_bar/view/main/navbar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.initialize("958e39d4-1b6d-40f1-a50a-c513d9a7a39e");
  OneSignal.Notifications.requestPermission(true);
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'timeSync',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const NavBarPage(),
    );
  }
}
