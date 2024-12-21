import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/feature/home/widget/text/home_text.dart';
import 'package:time_async/src/feature/notification/controller/notification_controller.dart';

class FavoritNotification extends StatefulWidget {
  const FavoritNotification({super.key});

  @override
  State<FavoritNotification> createState() => _FavoritNotificationState();
}

class _FavoritNotificationState extends State<FavoritNotification> {
  final controller = Get.put(NotificationController());
  User user = User();
  @override
  void initState() {
    initMethod();
    super.initState();
  }

  Future<void> initMethod() async {
    await user.loadToken();

    await controller.getFavNotification();
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
                "Favourite",
              ),
              Obx(
                () => controller.favNotification.isEmpty
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
                        itemCount: controller.favNotification.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return 20.0.kH;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          var isFav =
                              controller.favNotification[index].isFav.obs;
                          return _buildFavNotificationContainer(
                              context, index, isFav);
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

  _buildFavNotificationContainer(
      BuildContext context, int index, RxBool isFav) {
    return GestureDetector(
      onTap: () {
        // Show the dialog with the notification message
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
                      DateTime.parse(controller.favNotification[index].timeSent
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
              content:
                  HomeText.titlText(controller.favNotification[index].response),
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
                "Task Name: ${controller.favNotification[index].taskName.toString()}",
              ),
            ),
            const Spacer(),
            Obx(() => GestureDetector(
                  onTap: () async {
                    // Set loading state

                    // Remove notification
                    await controller.putNotification(
                      controller.favNotification[index].id,
                      false,
                    );

                    // Update the list
                    controller.favNotification.removeAt(index);

                    // Update notifications
                    await controller.getFavNotification();

                    // Clear loading state
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
    );
  }
}
