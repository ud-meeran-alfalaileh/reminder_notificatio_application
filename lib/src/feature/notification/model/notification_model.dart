class NotificationModel {
  final int id;
  final int userId;
  final DateTime timeSent;
  final String response;
  final int taskId;
  final bool isFav;
  final String taskName;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.timeSent,
    required this.response,
    required this.taskId,
    required this.isFav,
    required this.taskName,
  });

  // Factory constructor to create a NotificationModel from a JSON map
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      timeSent: DateTime.parse(json['timeSent'] as String),
      response: json['response'] as String,
      taskName: json['taskName'] ?? "",
      taskId: json['taskId'] as int,
      isFav: json['isFav'] as bool,
    );
  }

  // Static method to parse a list of JSON objects into a list of NotificationModel
  static List<NotificationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
  }
}
