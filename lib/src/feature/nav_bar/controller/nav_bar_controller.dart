import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:time_async/src/core/api/end_points.dart';
import 'package:time_async/src/core/api/netwok_info.dart';
import 'package:time_async/src/core/api/status_code.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/login/view/pages/login_page.dart';
import 'package:get/get.dart';
 import 'package:onesignal_flutter/onesignal_flutter.dart';

class NavController extends GetxController {

  RxInt selectedIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  User user = User();
  @override
  Future<void> onInit() async {
     setSelectedIndex(0);
    super.onInit();
  }

  void logout() async {
     OneSignal.logout();

    Get.offAll(() => const LoginPage());
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

}
