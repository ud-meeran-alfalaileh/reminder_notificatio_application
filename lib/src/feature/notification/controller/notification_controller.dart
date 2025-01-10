import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/notification/model/notification_model.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notification = <NotificationModel>[].obs;
  RxList<NotificationModel> favNotification = <NotificationModel>[].obs;
  User user = User();

  @override
  void onInit() async {
    await user.loadToken();
    print("object${user.userId}");
    // await getNotification();

    super.onInit();
  }

  var isLoading = false.obs;
  Future<void> getNotification(id) async {
    try {
      print(user.userId.value);
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
            "http://166.1.227.210:7010/api/Notifications/GetTaskAndNotficatioByUserId/${id}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        notification.value = NotificationModel.fromJsonList(responseData);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;

      print(e);
    }
  }

  Future<void> getFavNotification() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
            "http://166.1.227.210:7010/api/Notifications/GetNotificationsAndTaskByUserIdWhereisFav/${user.userId}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        favNotification.value = NotificationModel.fromJsonList(responseData);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;

      print(e);
    }
  }

  Future<void> putNotification(int id, bool isFav) async {
    try {
      var body = jsonEncode({
        'notificationId': id,
        "isFav": isFav,
      });

      final response = await http.put(
        Uri.parse("http://166.1.227.210:7010/api/Notifications/update-isfav"),
        headers: {
          'Content-Type': 'application/json', // Specify JSON format
        },
        body: body,
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
      } else {
        // Handle non-200 status codes
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
