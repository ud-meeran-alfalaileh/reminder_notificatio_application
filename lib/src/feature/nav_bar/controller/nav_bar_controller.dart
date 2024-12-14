import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:time_async/src/core/api/api_services.dart';
import 'package:time_async/src/core/api/end_points.dart';
import 'package:time_async/src/core/api/injection_container.dart';
import 'package:time_async/src/core/api/netwok_info.dart';
import 'package:time_async/src/core/api/status_code.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/login/view/pages/login_page.dart';
import 'package:get/get.dart';
 import 'package:onesignal_flutter/onesignal_flutter.dart';

class NavController extends GetxController {
  final DioConsumer dioConsumer = sl<DioConsumer>();

  RxInt selectedIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  RxBool isLoading = false.obs;
  RxBool status = true.obs;
  RxBool haveTime = false.obs;
  User user = User();
  @override
  Future<void> onInit() async {
    await user.loadVendorId();
    setSelectedIndex(0);
    super.onInit();
  }

  void logout() async {
    await user.clearVendorId();
    OneSignal.logout();

    Get.offAll(() => const LoginPage());
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> getVendorsById() async {
    isLoading.value = true;

    try {
      final response =
          await dioConsumer.get("${EndPoints.getVendorId}/${user.vendorId}");

      if (response.statusCode == StatusCode.ok) {
        try {
          final dynamic jsonData = json.decode(response.data);

          final vendorDetails = jsonData['status'];
          print(vendorDetails);
          status.value = !vendorDetails;

          isLoading.value = false;
        } catch (e) {
          print(e);
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getVendorsWorkingTime() async {
    isLoading.value = true;

    try {
      final response = await dioConsumer
          .get("${EndPoints.getVendorId}/${user.vendorId}/details");

      if (response.statusCode == StatusCode.ok) {
        try {
          final dynamic jsonData = json.decode(response.data);

          final workingDetails = jsonData['workingTime'];
          if (workingDetails == "Not Available") {
            Get.offAll(() => const Scaffold());
          } else {
            haveTime.value = false;
          }

          isLoading.value = false;
        } catch (e) {
          print(e);
        }

        isLoading.value = false;
      } else {}
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }
}
