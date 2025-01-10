import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/feature/home/controller/home_controller.dart';

import '../../core/user.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  // final CalenderControllerr controller = Get.put(CalenderControllerr());
  final controller = Get.put(HomeController());
  User user = User();

  @override
  void initState() {
    initMethod();

    super.initState();
  }

  initMethod() async {
    await user.loadToken();

    await controller.getTasks(user.userId);
  }

  // Example of your task data

  @override
  Widget build(BuildContext context) {
    // Map task data to Meeting objects
    final List<Meeting> meetings = controller.tasks.map((task) {
      final DateTime taskDate = DateTime.parse(task.taskDate);
      final List<String> timeParts = task.taskTime.split(":");
      final DateTime startTime = DateTime(
        taskDate.year,
        taskDate.month,
        taskDate.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );

      return Meeting(
        task.taskName,
        task.userId.toString(),
        task.taskDescription,
        startTime,
        startTime.add(const Duration(hours: 1)), // Default 1-hour duration
        task.taskStatus == "Done"
            ? AppTheme.lightAppColors.black
            : AppTheme.lightAppColors.primary.withOpacity(0.3),
        false,
      );
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 90, top: 10),
              child: Obx(() {
                // Ensure the task list is reactive
                final List<Meeting> meetings = controller.tasks.map((task) {
                  final DateTime taskDate = DateTime.parse(task.taskDate);
                  final List<String> timeParts = task.taskTime.split(":");
                  final DateTime startTime = DateTime(
                    taskDate.year,
                    taskDate.month,
                    taskDate.day,
                    int.parse(timeParts[0]),
                    int.parse(timeParts[1]),
                  );

                  return Meeting(
                    task.taskName,
                    task.userId.toString(),
                    task.taskDescription,
                    startTime,
                    startTime.add(
                        const Duration(hours: 1)), // Default 1-hour duration
                    task.taskStatus == "Done"
                        ? AppTheme.lightAppColors.black
                        : AppTheme.lightAppColors.primary.withOpacity(0.3),
                    false,
                  );
                }).toList();

                return SfCalendar(
                  view: CalendarView.month,
                  dataSource: MeetingDataSource(meetings),
                  monthViewSettings: MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                    showAgenda: true,
                    monthCellStyle: MonthCellStyle(
                      backgroundColor:
                          Colors.white, // Set cell background color to white
                      todayBackgroundColor:
                          AppTheme.lightAppColors.primary.withOpacity(0.3),
                      trailingDatesBackgroundColor: Colors.white,
                      leadingDatesBackgroundColor: Colors.white,
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      trailingDatesTextStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                      leadingDatesTextStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  headerStyle: CalendarHeaderStyle(
                    backgroundColor: AppTheme.lightAppColors.background,
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightAppColors.black,
                    ),
                  ),
                  viewHeaderStyle: ViewHeaderStyle(
                    backgroundColor: Colors.grey[200],
                    dayTextStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  todayHighlightColor: AppTheme.lightAppColors.primary,
                  cellBorderColor: Colors.grey,
                  selectionDecoration: BoxDecoration(
                    color: AppTheme.lightAppColors.bordercolor.withOpacity(0.3),
                    border: Border.all(
                        color: AppTheme.lightAppColors.black, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

class Meeting {
  Meeting(this.eventName, this.userName, this.location, this.from, this.to,
      this.background, this.isAllDay);

  final String eventName;
  final String userName;
  final String location;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;

  @override
  String getSubject(int index) => appointments![index].eventName;

  @override
  Color getColor(int index) => appointments![index].background;

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;
}
