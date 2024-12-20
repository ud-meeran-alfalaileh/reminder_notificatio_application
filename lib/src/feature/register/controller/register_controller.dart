import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/nav_bar/view/main/navbar_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  var isLoading = false.obs;
  User user = User();

  vaildEmail(String? email) {
    if (!GetUtils.isEmail(email!)) {
      return "wrong Email".tr;
    }
    return null;
  }

  validConfirmPassword() {
    if (confirmPassword.text != password.text) {
      return "the passwords doesnt match".tr;
    }
    return null;
  }

  vaildPassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 8)) {
      return "password must be 6 length".tr;
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

  Future<void> register(context) async {
    // Check if the context is still mounted before showing any SnackBars
    isLoading.value = true;
    var body = jsonEncode({
      "email": email.text.trim(),
      "password": password.text.trim(),
    });

    final response = await http.post(
      Uri.parse('http://166.1.227.102:7010/api/User/register'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        final token = jsonData['userId'];

        await user.saveId(token);
        user.userId.value = token;
        loginUser(token.toString());
        isLoading.value = false;

        Get.offAll(const NavBarPage());

        password.clear();
      } else {
        final jsonData = json.decode(response.body);

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: jsonData,
          ),
        );
        isLoading.value = false;
      }
    } catch (error) {
      isLoading.value = true;
      print(error);

      print(error);
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: error.toString(),
        ),
      );
    }
  }
}
