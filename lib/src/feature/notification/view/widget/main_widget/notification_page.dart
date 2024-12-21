import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/chat_bot/widget/main_widget/chat_page.dart';
import 'package:time_async/src/feature/home/widget/text/home_text.dart';
import 'package:time_async/src/feature/notification/controller/notification_controller.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final controller = Get.put(NotificationController());
  User user = User();
  @override
  void initState() {
    super.initState();
  }

  Future<void> initMethod() async {
    controller.notification.clear();
    // controller.favNotification.clear();
    await user.loadToken();
    await controller.getNotification(user.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeText.secText(
                "Notification",
              ),
              Obx(
                () => controller.notification.isEmpty
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            100.0.kH,
                            Image.asset(
                              'assets/image/empty.png',
                              width: context.screenWidth * .5,
                              color: Colors.white,
                            ),
                            5.0.kH,
                            HomeText.mainText("There is no item here ")
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(20),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.notification.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return 20.0.kH;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          var isLoadingFav = false.obs;

                          var isFav = controller.notification[index].isFav.obs;
                          return buildNotificationContainer(
                              context, index, isFav, isLoadingFav);
                        },
                      ),
              ),
              100.0.kH
            ],
          ),
        ),
      ),
    );
  }

  Stack buildNotificationContainer(
      BuildContext context, int index, RxBool isFav, RxBool isLoadingFav) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              print(controller.notification[index].timeSent);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppTheme.lightAppColors.background,
                    title: Column(
                      children: [
                        Text(
                          'Notification',
                          style: TextStyle(
                            fontFamily: 'Kanti',
                            fontSize: 20,
                            color: AppTheme.lightAppColors.mainTextcolor,
                            fontWeight: FontWeight
                                .w300, // Use FontWeight.bold for the bold variant
                          ),
                        ),
                        Text(
                          DateFormat('dd MMM yyyy, hh:mm a').format(
                            DateTime.parse(controller
                                .notification[index].timeSent
                                .toString()),
                          ),
                          style: TextStyle(
                            fontFamily: 'Kanti',
                            fontSize: 20,
                            color: AppTheme.lightAppColors.mainTextcolor,
                            fontWeight: FontWeight
                                .w300, // Use FontWeight.bold for the bold variant
                          ),
                        ),
                      ],
                    ),
                    content: HomeText.titlText(
                        controller.notification[index].response),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                            fontFamily: 'Kanti',
                            fontSize: 14,
                            color: AppTheme.lightAppColors.mainTextcolor,
                            fontWeight: FontWeight
                                .w300, // Use FontWeight.bold for the bold variant
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              width: context.screenWidth * .86,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff363E46),
                    Color(0xff3F4850),
                  ],
                ),
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
              child: Row(
                children: [
                  SizedBox(
                    width: context.screenWidth * .6,
                    child: HomeText.notificationText(
                        "Task Name: ${controller.notification[index].taskName.toString()}"),
                  ),
                  const Spacer(),
                  Obx(() => isLoadingFav.value
                      ? CircularProgressIndicator(
                          color: AppTheme.lightAppColors.primary,
                        )
                      : GestureDetector(
                          onTap: () async {
                            isLoadingFav.value = true;
                            isFav.value = !isFav.value;
                            await controller.putNotification(
                                controller.notification[index].id, isFav.value);
                            print(isFav.value);
                            print(
                              controller.notification[index].id,
                            );
                            isLoadingFav.value = false;
                          },
                          child: Image.asset(
                            isFav.value
                                ? "assets/image/fav.png"
                                : "assets/image/unFav.png",
                            width: context.screenWidth * .1,
                          ),
                        )),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => ChatPage(
                  description: controller.notification[index].taskName,
                  notification: controller.notification[index].response,
                  title: controller.notification[index].taskName,
                ));
          },
          child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/image/aiLogo.png')),
        )
      ],
    );
  }
}
