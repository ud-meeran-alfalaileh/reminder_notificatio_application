import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/nav_bar/view/main/navbar_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginController extends GetxController {
  final emailcontroller = TextEditingController();
  final password = TextEditingController();
  RxBool isLoading = false.obs;

  RxBool unauthorized = false.obs;

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
      return "invalid email".tr;
    }
    return null;
  }

  vaildPassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 5)) {
      return "password must be 6 length".tr;
    }
    return null;
  }

  Future<void> loginUser(externalId) async {
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
        "email": emailcontroller.text.trim(),
        "password": password.text.trim(),
      });
      final response = await http.post(
        Uri.parse("http://166.1.227.102:7010/api/User/login"),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final token = jsonData['userId'];
        await user.saveId(token);
        user.userId.value = token;
        await loginUser(token.toString());

        isLoading.value = false;

        Get.offAll(const NavBarPage());
        emailcontroller.clear();
        password.clear();
      } else {
        isLoading.value = false;

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: 'Invalid login credentials '.tr,
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
