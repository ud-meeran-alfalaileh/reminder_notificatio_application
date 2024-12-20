import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/home/model/tesk_model.dart';

class HomeController extends GetxController {
  var taskName = TextEditingController();
  var taskDescription = TextEditingController();
  var taskTime = TextEditingController();
  var taskDate = TextEditingController();
  var notificationSetting = TextEditingController();
  RxString notificationSettingss = ''.obs;
  RxInt notificationSettingssTime = 0.obs;
  var learnignnotification = false.obs;
  Rx<TaskModel?> task = Rx<TaskModel?>(null);
  var showTask = false.obs;

  RxList<Period> notificationSettings = [
    Period(name: "Weekly", time: 168),
    Period(name: "Daily", time: 24),
    Period(name: "2 hour", time: 2)
  ].obs;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  User user = User();
  @override
  void onInit() async {
    await user.loadToken();
    await getTasks();

    super.onInit();
  }

  Future<void> addTask() async {
    final body = jsonEncode({
      "userId": user.userId.value,
      "taskName": taskName.text.trim(),
      "taskDescription": taskDescription.text.trim(),
      "taskTime": taskTime.text.trim(),
      "taskDate": taskDate.text.trim(),
      "period": notificationSettingssTime.value,
      "notification": learnignnotification.value
    });
    print(body);
    final response = await http.post(
      Uri.parse("http://166.1.227.102:7010/api/Tasks"),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      await getTasks();
      Get.back();
    }
  }

  Future<void> updateTask(id) async {
    final body = jsonEncode({
      'id': id,
      "userId": user.userId.value,
      "taskName": taskName.text.trim(),
      "taskDescription": taskDescription.text.trim(),
      "taskTime": taskTime.text.trim(),
      "taskDate": taskDate.text.trim(),
      "period": notificationSettingssTime.value,
      "notification": learnignnotification.value
    });
    print(body);
    final response = await http.put(
      Uri.parse("http://166.1.227.102:7010/api/Tasks/Update"),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      await getTasks();
      Get.back();
    }
  }

  Future<void> deleteTask(id) async {
    final response = await http.delete(
      Uri.parse("http://166.1.227.102:7010/api/Tasks/Delete/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      await getTasks();
      Get.back();
    }
  }

  Future<void> getTasks() async {
    final response = await http.get(
      Uri.parse(
          "http://166.1.227.102:7010/api/Tasks/GetByUserId/${user.userId}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      tasks.value = TaskModel.fromList(responseData);
    }
    print(response.body);
    print(user.userId);
  }
}

class Period {
  String name;
  int time;
  Period({
    required this.name,
    required this.time,
  });
}
