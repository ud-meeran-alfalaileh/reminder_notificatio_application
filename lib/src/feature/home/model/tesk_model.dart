import 'package:get/get.dart';

class TaskModel {
  final String taskName;
  final String taskDescription;
  final String taskTime;
  final String taskDate;
  final String notificationSetting;
  final RxBool learnignnotification;
  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.taskTime,
    required this.taskDate,
    required this.notificationSetting,
    required this.learnignnotification,
  });
}
