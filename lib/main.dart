import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/core/api/injection_container.dart' as di;
import 'package:time_async/src/feature/nav_bar/view/main/navbar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gens',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const NavBarPage(),
    );
  }
}
