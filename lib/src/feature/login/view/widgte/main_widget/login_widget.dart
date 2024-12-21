import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/core/utils/loading_page.dart';
import 'package:time_async/src/feature/login/controller/login_controller.dart';
import 'package:time_async/src/feature/login/model/login_form_model.dart';
import 'package:time_async/src/feature/login/view/widgte/collection/auth_form_widget.dart';
import 'package:time_async/src/feature/login/view/widgte/text/login_text.dart';
import 'package:time_async/src/feature/register/view/widget/main_widget/register_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final controller = Get.put(LoginController());

  RxString errorText = "valid".obs;
  String? validateAllFields() {
    RxList<String?> errors = <String>[].obs;

    // Validate each form field and collect errors
    final emailError = controller.vaildEmail(controller.emailcontroller.text);
    final passwordError = controller.vaildPassword(controller.password.text);

    if (emailError != null) errors.add("- $emailError");
    if (passwordError != null) errors.add("- $passwordError");

    if (errors.isNotEmpty) {
      return errors.first;
    }
    return "valid";
  }

  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RxBool showPassword = true.obs;
    return Obx(
      () => Stack(
        children: [
          Container(
              width: context.screenWidth,
              decoration: BoxDecoration(
                  color: AppTheme.lightAppColors.background,
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: fromKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: 20,
                      // ),
                      50.0.kH,

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/image/logo (2).png',
                              // width: context.screenWidth * .6,
                              height: context.screenHeight * .3,
                              fit: BoxFit.fitWidth,
                            ),
                            10.0.kH,
                            LoginText.mainText('Sign In'),
                            Obx(() {
                              return errorText.value != "valid"
                                  ? Row(
                                      children: [
                                        Text(
                                          errorText.value,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    )
                                  : const SizedBox
                                      .shrink(); // If no errors, display nothing
                            }),
                            AuthForm(
                              formModel: FormModel(
                                  icon: Icons.person_2_outlined,
                                  controller: controller.emailcontroller,
                                  enableText: false,
                                  hintText: 'Email'.tr,
                                  invisible: false,
                                  validator: null,
                                  type: TextInputType.emailAddress,
                                  inputFormat: [],
                                  onTap: () {}),
                            ),
                            (20.5).kH,
                            //password
                            Stack(
                              children: [
                                AuthForm(
                                  formModel: FormModel(
                                      icon: Icons.lock_outline,
                                      controller: controller.password,
                                      enableText: false,
                                      hintText: 'Password'.tr,
                                      invisible: showPassword.value,
                                      validator: null,
                                      type: TextInputType.text,
                                      inputFormat: [],
                                      onTap: () {}),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showPassword.value =
                                              !showPassword.value;
                                        },
                                        icon: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 20, right: 20),
                                          child: Icon(
                                            !showPassword.value
                                                ? Icons.remove_red_eye_outlined
                                                : Icons.remove_red_eye,
                                            color:
                                                AppTheme.lightAppColors.primary,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                nextButton(() {
                                  errorText.value = validateAllFields()!;
                                  errorText.value == 'valid'
                                      ? controller.login(context)
                                      : null;
                                  // Get.to(NavBarPage());
                                }),
                              ],
                            ),
                            10.0.kH,
                          ],
                        ),
                      ),
                      Container(
                          height: context.screenHeight * .03,
                          width: context.screenWidth,
                          decoration: BoxDecoration(
                              color: AppTheme.lightAppColors.background,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          child: Center(
                            child: LoginText.haveAccount(() {
                              Get.to(() => const RegisterPage());
                            }),
                          )),
                    ],
                  ),
                ),
              )),
          controller.isLoading.value
              ? loadingPage(context)
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
