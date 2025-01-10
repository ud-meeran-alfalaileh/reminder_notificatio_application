import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/home/model/task_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomeController extends GetxController {
  var taskName = TextEditingController();
  var taskDescription = TextEditingController();
  var taskTime = TextEditingController();
  var taskDate = TextEditingController();
  var notificationSetting = TextEditingController();
  RxString notificationSettingss = ''.obs;
  RxInt notificationSettingssTime = 0.obs;
  RxString priorityName = "".obs;
  RxString status = "".obs;
  var learnignnotification = false.obs;
  Rx<TaskModel?> task = Rx<TaskModel?>(null);
  var showTask = false.obs;

  RxList<Period> notificationSettings = [
    Period(name: "Weekly", time: 168),
    Period(name: "Daily", time: 24),
    Period(name: "2 hour", time: 2),
  ].obs;
  RxList<Priority> priority = [
    Priority(name: "Low", color: "#00FF00"), // Green
    Priority(name: "Medium", color: "#3F9FD7"), // Yellow
    Priority(name: "High", color: "#FF0000"), // Red
  ].obs;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  User user = User();
  @override
  void onInit() async {
    await user.loadToken();
    // await getTasks(user.);

    super.onInit();
  }

  vaildField(String field) {
    if (field.isEmpty) {
      return "fill the ".tr;
    }
    return null;
  }

  Future<void> addTask() async {
    final body = jsonEncode({
      "userId": user.userId.value,
      "taskName": taskName.text.trim(),
      "taskDescription": taskDescription.text.trim(),
      "taskTime": taskTime.text.trim(),
      "taskStatus": "In Progress",
      "taskproperty": priorityName.value,
      "taskDate": taskDate.text.trim(),
      "period": notificationSettingssTime.value,
      "notification": learnignnotification.value
    });
    print(body);
    final response = await http.post(
      Uri.parse("http://166.1.227.210:7010/api/Tasks"),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      await getTasks(user.userId);
      Get.back();
    }
  }

  Future<void> updateTask(id) async {
    tasks.clear();
    print(status.value);
    print(priorityName.value);
    final body = jsonEncode({
      'id': id,
      "userId": user.userId.value,
      "taskName": taskName.text.trim(),
      "taskDescription": taskDescription.text.trim(),
      "taskTime": taskTime.text.trim(),
      "taskStatus": status.value,
      "taskproperty": priorityName.value,
      "taskDate": taskDate.text.trim(),
      "period": notificationSettingssTime.value,
      "notification": learnignnotification.value
    });
    print(body);
    final response = await http.put(
      Uri.parse("http://166.1.227.210:7010/api/Tasks/Update"),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      await getTasks(user.userId);
      Get.back();
    }
  }

  Future<void> deleteTask(id) async {
    final response = await http.delete(
      Uri.parse("http://166.1.227.210:7010/api/Tasks/Delete/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      await getTasks(user.userId);
      Get.back();
    }
  }

  Future<void> getTasks(id) async {
    await user.loadToken();

    try {
      final response = await http.get(
        Uri.parse(
            "http://166.1.227.210:7010/api/Tasks/GetByUserId/${user.userId.value}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print(response.body);
      print(id);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        tasks.value = TaskModel.fromList(responseData);
      }
      print(response.body);
      print(user.userId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateStatus(id, status, context) async {
    await user.loadToken();

    try {
      var body = jsonEncode({"taskId": id, "status": status});
      final response = await http.put(
          Uri.parse("http://166.1.227.210:7010/api/Tasks/updatetaskstatus"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "The task marked as $status",
            backgroundColor: AppTheme.lightAppColors.primary,
          ),
        );
        getTasks(user.userId.value);
      }
    } catch (e) {
      print(e);
    }
  }
}

class Priority {
  String name;
  String color;
  Priority({
    required this.name,
    required this.color,
  });
}

class Period {
  String name;
  int time;
  Period({
    required this.name,
    required this.time,
  });
}
