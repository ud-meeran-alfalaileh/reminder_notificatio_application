import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/feature/home/controller/home_controller.dart';
import 'package:time_async/src/feature/home/model/tesk_model.dart';
import 'package:time_async/src/feature/home/widget/collection/task_form_widget.dart';
import 'package:time_async/src/feature/home/widget/text/home_text.dart';
import 'package:time_async/src/feature/login/model/login_form_model.dart';

class AddEditTaskPage extends StatefulWidget {
  const AddEditTaskPage({super.key, this.task, required this.type});
  final TaskModel? task;
  final String type;

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final controller = Get.put(HomeController());
  RxBool light = false.obs;
  @override
  void initState() {
    widget.type == 'edit'
        ? {
            controller.taskName.text = widget.task!.taskName,
            controller.taskDescription.text = widget.task!.taskDescription,
            controller.taskDate.text = widget.task!.taskDate,
            controller.taskTime.text = widget.task!.taskTime,
            controller.notificationSettingssTime.value = widget.task!.period,
            controller.learnignnotification.value =
                widget.task!.learnignnotification,
            controller.notificationSetting.text =
                widget.task!.period.toString(),
            controller.notificationSettingss.value =
                widget.task!.notificationSetting,
            light.value = widget.task!.learnignnotification
          }
        : {
            controller.taskName.clear(),
            controller.taskDescription.clear(),
            controller.taskDate..clear(),
            controller.taskTime..clear(),
            controller.notificationSetting.clear(),
            controller.learnignnotification.value = false,
            light.value = false
          };
    super.initState();
  }

  RxString errorText = "valid".obs;

  String? validateAllFields() {
    RxList<String?> errors = <String>[].obs;

    // Validate each form field and collect errors
    final nameError = controller.vaildField(controller.taskName.text);
    final descriptionError =
        controller.vaildField(controller.taskDescription.text);
    final dateError = controller.vaildField(controller.taskDate.text);
    final timeError = controller.vaildField(controller.taskTime.text);
    final notificationError = controller.notificationSettingssTime.value;

    if (nameError != null) errors.add("- $nameError name");
    if (descriptionError != null) errors.add("- $descriptionError description");
    if (timeError != null) errors.add("- $timeError Time");
    if (dateError != null) errors.add("- $dateError Date");

    if (notificationError == 0) errors.add("- choose time for notification");

    if (errors.isNotEmpty) {
      return errors.first;
    }
    return "valid";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppTheme.lightAppColors.mainTextcolor,
                        )),
                    Row(
                      children: [
                        Image.asset('assets/image/aiLogo.png'),
                        Obx(
                          () => Switch(
                            // This bool value toggles the switch.
                            value: light.value,
                            activeColor: AppTheme.lightAppColors.primary,
                            onChanged: (bool value) {
                              light.value = value;
                              controller.learnignnotification = light;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Obx(() {
                  return errorText.value != "valid"
                      ? Row(
                          children: [
                            Text(
                              errorText.value,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        )
                      : const SizedBox
                          .shrink(); // If no errors, display nothing
                }),
                20.0.kH,
                Row(
                  children: [
                    10.0.kW,
                    HomeText.mainText('Task Name'),
                  ],
                ),
                TaskFormWidget(
                    formModel: FormModel(
                        controller: controller.taskName,
                        enableText: false,
                        hintText: "Task Name",
                        invisible: false,
                        validator: null,
                        type: TextInputType.text,
                        inputFormat: [],
                        onTap: () {})),
                20.0.kH,
                Row(
                  children: [
                    10.0.kW,
                    HomeText.mainText('Task Description'),
                  ],
                ),
                TaskFormWidget(
                    formModel: FormModel(
                        controller: controller.taskDescription,
                        enableText: false,
                        hintText: "Task Description",
                        invisible: false,
                        validator: null,
                        type: TextInputType.text,
                        inputFormat: [],
                        onTap: () {})),
                20.0.kH,
                Row(
                  children: [
                    10.0.kW,
                    HomeText.mainText('Task Time'),
                  ],
                ),
                Stack(
                  children: [
                    TaskFormWidget(
                        formModel: FormModel(
                            controller: controller.taskTime,
                            enableText: true,
                            hintText: "Task Time",
                            invisible: false,
                            validator: null,
                            type: TextInputType.text,
                            inputFormat: [],
                            onTap: () {})),
                    GestureDetector(
                      onTap: () {
                        taskTimeWidget(context, controller.taskTime);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.height * .06,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                20.0.kH,
                Row(
                  children: [
                    10.0.kW,
                    HomeText.mainText('Task Date'),
                  ],
                ),
                Stack(
                  children: [
                    TaskFormWidget(
                        formModel: FormModel(
                            controller: controller.taskDate,
                            enableText: true,
                            hintText: "Task Date",
                            invisible: false,
                            validator: null,
                            type: TextInputType.text,
                            inputFormat: [],
                            onTap: () {})),
                    GestureDetector(
                      onTap: () {
                        taskDateWidget(context, controller.taskDate);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.height * .06,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                20.0.kH,
                SizedBox(
                  width: context.screenWidth * .9,
                  height: context.screenHeight * .06,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.notificationSettings.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return 10.0.kW;
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          controller.notificationSetting.text =
                              controller.notificationSettings[index].name;

                          controller.notificationSettingssTime.value =
                              controller.notificationSettings[index].time;
                          print(controller.notificationSettingssTime.value);
                        },
                        child: Obx(
                          () => Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: controller
                                            .notificationSettingssTime.value ==
                                        controller
                                            .notificationSettings[index].time
                                    ? AppTheme.lightAppColors.primary
                                    : AppTheme.lightAppColors.background,
                              ),
                              child: Center(
                                child: HomeText.titlShowText(controller
                                    .notificationSettings[index].name),
                              )),
                        ),
                      );
                    },
                  ),
                ),
                20.0.kH,
                GestureDetector(
                  onTap: () {
                    errorText.value = validateAllFields()!;
                    errorText.value == 'valid'
                        ? {
                            widget.type == 'add'
                                ? {
                                    controller.addTask(),
                                  }
                                : {controller.updateTask(widget.task!.id)}
                          }
                        : null;
                  },
                  child: Container(
                    width: context.screenWidth * .5,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.lightAppColors.primary.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Shadow color
                          blurRadius: 6, // How blurry the shadow is
                          spreadRadius: 10, // How much the shadow spreads
                          offset: const Offset(2, 4), // Position of the shadow
                        ),
                      ],
                    ),
                    child: Center(
                        child: HomeText.mainText(
                            widget.type == 'edit' ? "Edit" : "Add")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future taskTimeWidget(BuildContext context, TextEditingController text) async {
  TimeOfDay? newTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          // Customizing the color of the TimePicker
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.white,
            timeSelectorSeparatorColor: WidgetStateColor.resolveWith((states) {
              return Colors.black; // Selected hour/minute text color
            }),
            dialBackgroundColor: Colors.black.withOpacity(0.1),
            dialHandColor: AppTheme.lightAppColors.primary, // Hand color
            dialTextColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white; // Selected hour color
              }
              return Colors.black; // Default hour color
            }),
            dayPeriodColor: AppTheme.lightAppColors.primary,
            dayPeriodTextColor: AppTheme.lightAppColors.mainTextcolor,
            hourMinuteColor: Colors.white,
            hourMinuteTextColor: AppTheme
                .lightAppColors.primary, // Color of the selected time (hours)
          ),
        ),
        child: child!,
      );
    },
  );

  if (newTime != null) {
    final hour = newTime.hour.toString().padLeft(2, '0');
    final minute = newTime.minute.toString().padLeft(2, '0');
    const seconds =
        '00'; // Add seconds as "00" since TimeOfDay does not support seconds.

    text.text = "$hour:$minute:$seconds"; // Display the time in hh:mm:ss format
  }
}

Future<void> taskDateWidget(
    BuildContext context, TextEditingController text) async {
  DateTime? newDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          // Customizing the color of the DatePicker
          datePickerTheme: DatePickerThemeData(
            backgroundColor: Colors.white,
            headerBackgroundColor: AppTheme.lightAppColors.primary,
            headerForegroundColor: Colors.white,
            dayForegroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white; // Selected day color
              }
              return Colors.black; // Default day color
            }),
            dayBackgroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return AppTheme
                    .lightAppColors.primary; // Background for selected day
              }
              return Colors.white; // Default background
            }),
            yearForegroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white; // Selected year color
              }
              return Colors.black; // Default year color
            }),
          ),
        ),
        child: child!,
      );
    },
  );

  if (newDate != null) {
    text.text =
        "${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}";
    // Display the selected date in YYYY-MM-DD format
  }
}
