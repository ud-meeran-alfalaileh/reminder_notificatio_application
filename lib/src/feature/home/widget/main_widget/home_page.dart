import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/home/controller/home_controller.dart';
import 'package:time_async/src/feature/home/model/task_model.dart';
import 'package:time_async/src/feature/home/widget/collection/add_edit_task_page.dart';
import 'package:time_async/src/feature/home/widget/text/home_text.dart';
import 'package:time_async/src/feature/nav_bar/view/main/navbar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(HomeController());
  User user = User();
  @override
  void initState() {
    initMethod();
    super.initState();
  }

  Future<void> initMethod() async {
    await user.loadToken();

    await controller.getTasks(user.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: context.screenWidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image.asset('assets/image/test.jpg'),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          await user.clearId();
                          Get.offAll(() => const NavBarPage());
                          OneSignal.logout();
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ))
                  ],
                ),
                20.0.kH,
                Image.asset(
                  'assets/image/clock.png',
                ),
                20.0.kH,
                Row(
                  children: [
                    20.0.kW,
                    HomeText.mainText("  Tasks & Alarms"),
                  ],
                ),
                10.0.kH,
                Obx(
                  () => ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.tasks.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return 10.0.kH;
                    },
                    itemBuilder: (BuildContext context, int index) {
                      var light =
                          controller.tasks[index].taskStatus == "In Progress"
                              ? false.obs
                              : true.obs;
                      return taskContainer(context, light,
                          controller.tasks[index], controller, index);
                    },
                  ),
                ),
                10.0.kH,
                GestureDetector(
                    onTap: () {
                      controller.task.value = null;
                      Get.to(() => const AddEditTaskPage(
                            type: 'add',
                          ));
                    },
                    child: Image.asset('assets/image/addButton.png')),
                100.0.kH,
              ],
            ),
          ),
        ),
      ),
    );
  }

  taskContainer(BuildContext context, RxBool light, TaskModel model,
      HomeController controller, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddEditTaskPage(
              type: 'edit',
              task: model,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Container(
              width: context.screenWidth * .8,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff363E46),
                      Color(0xff3F4850),
                    ]),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 10,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  HomeText.titlText(model.taskName),
                  Row(
                    children: [
                      HomeText.secText(model.taskTime),
                      const Spacer(),
                      Obx(
                        () => Switch(
                          value: light.value,
                          activeColor:
                              AppTheme.lightAppColors.primary.withOpacity(0.5),
                          onChanged: (bool value) {
                            light.value = !light.value;
                            if (light.value == true) {
                              controller.updateStatus(
                                  model.id, "Done", context);
                            } else {
                              controller.updateStatus(
                                  model.id, "In Progress", context);
                            }
                            print(light.value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      controller.deleteTask(model.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: AppTheme.lightAppColors.primary,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {
                      Get.to(() => AddEditTaskPage(
                            type: 'edit',
                            task: model,
                          ));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: AppTheme.lightAppColors.primary,
                      size: 30,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
