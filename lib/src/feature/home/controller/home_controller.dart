import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/feature/home/model/tesk_model.dart';

class HomeController extends GetxController {
  var taskName = TextEditingController();
  var taskDescription = TextEditingController();
  var taskTime = TextEditingController();
  var taskDate = TextEditingController();
  var notificationSetting = TextEditingController();
  RxString notificationSettingss = ''.obs;
  var learnignnotification = false;
  Rx<TaskModel?> task = Rx<TaskModel?>(null);
  var showTask = false.obs;
  RxList<String> notificationSettings = ["Weekly", "Daily", "2 hour"].obs;
  RxList<TaskModel> tasks = [
    TaskModel(
      taskName: "Complete Flutter project",
      taskDescription: "Finish the UI and functionality of the Flutter app.",
      taskTime: "10:00 AM",
      taskDate: "2024-12-15",
      notificationSetting: "Enabled",
      learnignnotification: true.obs,
    ),
    TaskModel(
      taskName: "Team meeting",
      taskDescription: "Discuss project updates with the team.",
      taskTime: "3:00 PM",
      taskDate: "2024-12-16",
      notificationSetting: "Enabled",
      learnignnotification: false.obs,
    ),
    TaskModel(
      taskName: "Read technical article",
      taskDescription: "Read an article about advanced Flutter layouts.",
      taskTime: "8:00 PM",
      taskDate: "2024-12-17",
      notificationSetting: "Disabled",
      learnignnotification: true.obs,
    ),
    TaskModel(
      taskName: "Prepare for presentation",
      taskDescription: "Prepare slides and notes for the client presentation.",
      taskTime: "9:00 AM",
      taskDate: "2024-12-18",
      notificationSetting: "Enabled",
      learnignnotification: false.obs,
    ),
  ].obs;
}
