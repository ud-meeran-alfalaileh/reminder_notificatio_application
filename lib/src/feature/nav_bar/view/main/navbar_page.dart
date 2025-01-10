import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/core/user.dart';
import 'package:time_async/src/core/utils/loading_page.dart';
import 'package:time_async/src/feature/calendar/calendar_page.dart';
import 'package:time_async/src/feature/home/widget/main_widget/home_page.dart';
import 'package:time_async/src/feature/login/view/pages/login_page.dart';
import 'package:time_async/src/feature/nav_bar/controller/nav_bar_controller.dart';
import 'package:time_async/src/feature/nav_bar/view/main/custome_navbar.dart';
import 'package:time_async/src/feature/notification/controller/notification_controller.dart';
import 'package:time_async/src/feature/notification/view/widget/main_widget/favorit_notification.dart';
import 'package:time_async/src/feature/notification/view/widget/main_widget/notification_page.dart';
import 'package:time_async/src/feature/profile/profile_page.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  final NavController controller = Get.put(NavController());
  final notificationController = Get.put(NotificationController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isLoading = true.obs;
  User user = User();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        initialState();
      });
    });

    super.initState();
  }

  Future<void> initialState() async {
    await user.loadToken();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value == false) {
        return Scaffold(
          body: user.userId.value == 0
              ? const LoginPage()
              : Stack(
                  children: [
                    Obx(() {
                      switch (controller.selectedIndex.value) {
                        case 0:
                          return const HomePage();
                        case 1:
                          return const NotificationPage();
                        case 2:
                          return const CalendarWidget();
                        case 3:
                          return const FavoritNotification();
                        case 4:
                          return const ProfilePage();
                        // case 3:
                        //   return ChatPage();

                        default:
                          return Scaffold(
                            backgroundColor: AppTheme.lightAppColors.background,
                          );
                      }
                    }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: context.screenHeight * .09,
                        decoration: BoxDecoration(
                          color: AppTheme.lightAppColors.background,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppTheme.lightAppColors.black.withOpacity(.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CustomNavItem(
                              icon: const Center(
                                child: Icon(
                                  size: 30,
                                  Icons.home,
                                ),
                              ),
                              onTap: () {
                                controller.setSelectedIndex(0);
                              },
                              isSelected: controller.selectedIndex.value == 0,
                            ),
                            CustomNavItem(
                              icon: const Center(
                                child: Icon(
                                  size: 30,
                                  Icons.notifications,
                                ),
                              ),
                              onTap: () {
                                controller.setSelectedIndex(1);
                                notificationController
                                    .getNotification(user.userId);
                              },
                              isSelected: controller.selectedIndex.value == 1,
                            ),
                            CustomNavItem(
                              icon: const Center(
                                child: Icon(
                                  size: 30,
                                  Icons.calendar_month,
                                ),
                              ),
                              onTap: () {
                                controller.setSelectedIndex(2);
                              },
                              isSelected: controller.selectedIndex.value == 2,
                            ),
                            CustomNavItem(
                              icon: const Center(
                                child: Icon(
                                  size: 30,
                                  Icons.favorite,
                                ),
                              ),
                              onTap: () {
                                controller.setSelectedIndex(3);
                              },
                              isSelected: controller.selectedIndex.value == 3,
                            ),
                            // Use a Builder widget to access Scaffold context
                            Builder(
                              builder: (context) {
                                return CustomNavItem(
                                  icon: const Center(
                                    child: Icon(
                                      Icons.person_2_outlined,
                                    ),
                                  ),
                                  onTap: () {
                                    controller.setSelectedIndex(4);
                                  },
                                  isSelected:
                                      controller.selectedIndex.value == 4,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      } else {
        return loadingPage(context);
      }
    });
  }
}
