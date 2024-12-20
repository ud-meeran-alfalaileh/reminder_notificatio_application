import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final RxInt userId = 0.obs;

  clearId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('LoginId');
    userId.value = 0;
  }

  loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getInt('LoginId') ?? 0;
  }

  saveId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('LoginId', id); // Save the passed id
  }
}
