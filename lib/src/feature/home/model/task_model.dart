class TaskModel {
  final int id;
  final int userId;
  final String taskName;
  final String taskDescription;
  final String taskTime;
  final String taskDate;
  final String taskStatus;
  final String taskproperty;
  final int period;
  final String notificationSetting;
  bool learnignnotification;
  TaskModel({
    required this.id,
    required this.userId,
    required this.taskName,
    required this.taskDescription,
    required this.taskStatus,
    required this.taskproperty,
    required this.taskTime,
    required this.period,
    required this.taskDate,
    required this.notificationSetting,
    required this.learnignnotification,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'],
        userId: json['userId'],
        taskName: json['taskName'] ?? '',
        taskproperty: json['taskproperty'] ?? '',
        taskStatus: json['taskStatus'] ?? '',
        taskDescription: json['taskDescription'] ?? '',
        taskTime: json['taskTime'] ?? '',
        taskDate: json['taskDate'] ?? '',
        period: json['period'] ?? 2,
        notificationSetting: json['notificationSetting'] ?? '',
        learnignnotification: json['notification']);
  }
  static List<TaskModel> fromList(List<dynamic> jsonList) {
    return jsonList.map((json) => TaskModel.fromJson(json)).toList();
  }
}
