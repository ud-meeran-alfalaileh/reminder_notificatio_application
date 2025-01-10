import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/core/utils/loading_page.dart';
import 'package:time_async/src/feature/home/controller/home_controller.dart';
import 'package:time_async/src/feature/home/model/task_model.dart';
import 'package:time_async/src/feature/home/widget/text/home_text.dart';
import 'package:time_async/src/feature/profile/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileContrller = Get.put(ProfileController());

  final controller = Get.put(HomeController());
  final user = User();

  @override
  void initState() {
    super.initState();
    initMethod();
  }

  Future<void> initMethod() async {
    await user.loadToken();
    await controller.getTasks(user.userId.value);
  }

  @override
  Widget build(BuildContext context) {
    final tasks = controller.tasks;

    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: Obx(
          () => profileContrller.isloading.value
              ? loadingPage(context)
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeText.secText("Profile"),
                      Divider(
                        color: AppTheme.lightAppColors.bordercolor
                            .withOpacity(0.3),
                      ),
                      Center(
                        child: SfCircularChart(
                          title: const ChartTitle(text: 'Task Completion'),
                          legend: const Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                          ),
                          series: <RadialBarSeries<TaskData, String>>[
                            RadialBarSeries<TaskData, String>(
                              dataSource: getTaskData(tasks),
                              xValueMapper: (TaskData data, _) => data.status,
                              yValueMapper: (TaskData data, _) => data.value,
                              dataLabelMapper: (TaskData data, _) =>
                                  '${data.value} tasks',
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              cornerStyle: CornerStyle.bothCurve,
                              radius: '80%',
                              pointColorMapper: (TaskData data, _) {
                                switch (data.status) {
                                  case 'Completed':
                                    return Colors.amberAccent;
                                  case 'In Progress':
                                    return AppTheme
                                        .lightAppColors.secondaryColor;
                                  case 'Pending':
                                    return AppTheme
                                        .lightAppColors.containercolor;
                                  default:
                                    return Colors.grey;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      20.0.kH,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeText.mainText(
                                "Name: ${profileContrller.userData.value!.firstName} ${profileContrller.userData.value!.sectName} "),
                            HomeText.mainText(
                                "Email:  ${profileContrller.userData.value!.email} "),
                          ],
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

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:time_async/src/config/theme/theme.dart';
// import 'package:time_async/src/core/user.dart';
// import 'package:time_async/src/feature/home/controller/home_controller.dart';
// import 'package:time_async/src/feature/home/model/task_model.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final controller = Get.put(HomeController());
//   final user = User();

//   @override
//   void initState() {
//     super.initState();
//     initMethod();
//   }

//   Future<void> initMethod() async {
//     await user.loadToken();
//     await controller.getTasks(user.userId.value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.lightAppColors.background,
//       body: GetX<HomeController>(
//         builder: (controller) {
//           // if (controller.isLoading.value) {
//           //   return const Center(child: CircularProgressIndicator());
//           // }

//           if (controller.tasks.isEmpty) {
//             return const Center(child: Text('No tasks available.'));
//           }

//           final tasks = controller.tasks;
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           icon: const Icon(Icons.arrow_back_ios)),
//                       const Spacer(),
//                       const Text(
//                         'Task Report',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Task Details',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: tasks.length,
//                     itemBuilder: (context, index) {
//                       final task = tasks[index];
//                       return ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: task.taskStatus == "Done"
//                               ? AppTheme.lightAppColors.primary
//                               : Colors.grey,
//                           child: Icon(
//                             task.taskStatus == "Done"
//                                 ? Icons.check
//                                 : Icons.pending_actions,
//                             color: Colors.white,
//                           ),
//                         ),
//                         title: Text(task.taskName),
//                         subtitle: Text('Due: ${task.taskDate}'),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

List<TaskData> getTaskData(List<TaskModel> tasks) {
  final completed =
      tasks.where((task) => task.taskStatus == "Done").length.toDouble();
  final inProgress =
      tasks.where((task) => task.taskStatus == "In Progress").length.toDouble();
  final pending =
      tasks.where((task) => task.taskStatus == "Missed").length.toDouble();

  return [
    TaskData('Completed', completed),
    TaskData('In Progress', inProgress),
    TaskData('Missed', pending),
  ];
}

class TaskData {
  final String status;
  final double value;

  TaskData(this.status, this.value);
}
