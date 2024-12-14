import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:time_async/src/core/api/api_services.dart';
import 'package:time_async/src/core/api/end_points.dart';
import 'package:time_async/src/core/api/injection_container.dart';
import 'package:time_async/src/core/api/netwok_info.dart';
import 'package:time_async/src/core/api/status_code.dart';
import 'package:time_async/src/core/user.dart';
 import 'package:get/get.dart';
 import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:time_async/src/feature/nav_bar/view/main/navbar_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginController extends GetxController {
  final emailcontroller = TextEditingController();
  final password = TextEditingController();
  RxBool isLoading = false.obs;

  RxBool unauthorized = false.obs;
  final DioConsumer dioConsumer = sl<DioConsumer>();

  //validation
  String removeLeadingZero(String input) {
    if (input.startsWith("962")) {
      return input.substring(3); // Remove "962"
    } else if (input.startsWith("0")) {
      return input.replaceFirst(RegExp('^0+'), '');
    }
    return input;
  }

  vaildEmail(String? email) {
    if (!GetUtils.isEmail(email!)) {
      return "EmailValidate".tr;
    }
    return null;
  }

  vaildPassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 8)) {
      return "PasswordValidation".tr;
    }
    return null;
  }

  Future<void> loginUser(String externalId) async {
    try {
      await OneSignal.login(externalId);

      print("User logged in with external ID: $externalId");
    } catch (e) {
      print(e);
    }
  }

  User user = User();
  Future<void> login(context) async {
    isLoading.value = true;
    try {
      final body = jsonEncode({
        "phone": "962${removeLeadingZero(emailcontroller.text.trim())}",
        "password": password.text.trim(),
      });
      final response = await dioConsumer.post(EndPoints.login, body: body);

      if (response.statusCode == StatusCode.ok) {
        final jsonData = json.decode(response.data);
        final type = jsonData['userType'];
        final number = jsonData['phone'];
        print(response.data);
        print(number.toString());
        if (type == 'User') {
          final token = jsonData['userId'];
          await user.saveId(token);
          user.userId.value = token;
          await loginUser(number.toString());
          // showTopSnackBar(
          //   Overlay.of(context),
          //   CustomSnackBar.success(
          //     message: "loginSuccess".tr,
          //   ),
          // );
          isLoading.value = false;

          Get.offAll(const NavBarPage());
          emailcontroller.clear();
          password.clear();
        } else {
          final jsonData = json.decode(response.data);
          final token = jsonData['vendorId'];
          final number = jsonData['phone'];
          print("the phone number $number");
          await user.saveVendorId(token);
          user.vendorId.value = token;

          await loginUser(number.toString());
          isLoading.value = false;
          Get.offAll(const NavBarPage());
          emailcontroller.clear();
          password.clear();
        }
      } else {
        isLoading.value = false;

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: 'loginError'.tr,
          ),
        );

        unauthorized.value = true;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'loginError'.tr,
        ),
      );
      unauthorized.value = true;
    }
  }
}
