import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/feature/home/controller/home_controller.dart';
import 'package:time_async/src/feature/home/model/tesk_model.dart';
import 'package:time_async/src/feature/home/widget/collection/add_edit_task_page.dart';
import 'package:time_async/src/feature/home/widget/text/home_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: context.screenWidth,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
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
                              controller.tasks[index].learnignnotification;
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
            ],
          ),
        ),
      ),
    );
  }

  taskContainer(BuildContext context, RxBool light, TaskModel model,
      HomeController controller, index) {
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
              width: context.screenWidth * .81,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff363E46),
                      Color(0xff3F4850),
                    ]),
                // Card background color
                borderRadius: BorderRadius.circular(30), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    blurRadius: 6, // How blurry the shadow is
                    spreadRadius: 10, // How much the shadow spreads
                    offset: const Offset(2, 4), // Position of the shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  HomeText.titlText(model.taskName),
                  Row(
                    children: [
                      HomeText.secText(model.taskTime),
                      Spacer(),
                      Obx(
                        () => Switch(
                          // This bool value toggles the switch.
                          value: light.value,
                          activeColor:
                              AppTheme.lightAppColors.primary.withOpacity(0.5),
                          onChanged: (bool value) {
                            print(light.value);
                            light.value = value;
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      controller.tasks.removeAt(index);
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
