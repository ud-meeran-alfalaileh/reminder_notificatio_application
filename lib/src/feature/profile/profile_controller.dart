import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/profile/profile_model.dart';

class ProfileController extends GetxController {
  var isloading = false.obs;
  User user = User();
  @override
  void onInit() async {
    await user.loadToken();
    await getUser(user.userId.value);

    super.onInit();
  }

  Rx<UserModel?> userData = Rx<UserModel?>(null);
  Future<void> getUser(id) async {
    isloading.value = true;
    try {
      final response = await http.get(
        Uri.parse("http://166.1.227.210:7010/api/User/getuser/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print(response.body);
      print(id);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        userData.value = UserModel.fromJson(responseData);
      }
      isloading.value = false;

      print(response.body);
    } catch (e) {
      isloading.value = false;

      print(e);
    }
  }
}
