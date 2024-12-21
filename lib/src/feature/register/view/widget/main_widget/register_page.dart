import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/core/utils/loading_page.dart';
import 'package:time_async/src/feature/login/model/login_form_model.dart';
import 'package:time_async/src/feature/login/view/widgte/collection/auth_form_widget.dart';
import 'package:time_async/src/feature/login/view/widgte/text/login_text.dart';
import 'package:time_async/src/feature/register/controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool showPassword = true.obs;
    RxBool showConfirmPassword = true.obs;

    final controller = Get.put(RegisterController());
    RxString errorText = "valid".obs;
    String? validateAllFields() {
      RxList<String?> errors = <String>[].obs;

      // Validate each form field and collect errors
      final emailError = controller.vaildEmail(controller.email.text);
      final passwordError = controller.vaildPassword(controller.password.text);
      final confirmPasswordError = controller.validConfirmPassword();

      if (emailError != null) errors.add("- $emailError");
      if (passwordError != null) errors.add("- $passwordError");
      if (confirmPasswordError != null) errors.add("- $confirmPasswordError");

      if (errors.isNotEmpty) {
        return errors.first;
      }
      return "valid";
    }

    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: Obx(
        () => Stack(
          children: [
            Container(
                width: context.screenWidth,
                decoration: BoxDecoration(
                    color: AppTheme.lightAppColors.background,
                    borderRadius: BorderRadius.circular(20)),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (context.screenHeight * .1).kH,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/image/clock.png',
                                width: context.screenWidth * .6,
                                height: context.screenHeight * .3,
                                fit: BoxFit.fitWidth,
                              ),
                              10.0.kH,
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
                                    controller: controller.email,
                                    enableText: false,
                                    hintText: 'Email'.tr,
                                    invisible: false,
                                    validator: null,
                                    type: TextInputType.emailAddress,
                                    inputFormat: [],
                                    onTap: () {}),
                              ),
                              (5.5).kH,
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
                                                  ? Icons
                                                      .remove_red_eye_outlined
                                                  : Icons.remove_red_eye,
                                              color: AppTheme
                                                  .lightAppColors.primary,
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              (5.5).kH,
                              Stack(
                                children: [
                                  AuthForm(
                                    formModel: FormModel(
                                        icon: Icons.lock_outline,
                                        controller: controller.confirmPassword,
                                        enableText: false,
                                        hintText: 'Confirm Password'.tr,
                                        invisible: showConfirmPassword.value,
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
                                            showConfirmPassword.value =
                                                !showConfirmPassword.value;
                                          },
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 20, right: 20),
                                            child: Icon(
                                              !showConfirmPassword.value
                                                  ? Icons
                                                      .remove_red_eye_outlined
                                                  : Icons.remove_red_eye,
                                              color: AppTheme
                                                  .lightAppColors.primary,
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
                                        ? controller.register(context)
                                        : null;
                                  }),
                                ],
                              ),
                              20.0.kH,
                              Container(
                                  height: context.screenHeight * .03,
                                  width: context.screenWidth,
                                  decoration: BoxDecoration(
                                      color: AppTheme.lightAppColors.background,
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(30))),
                                  child: Center(
                                    child: LoginText.dontHaveAccount(() {
                                      Get.back();
                                    }),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            controller.isLoading.value
                ? loadingPage(context)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

nextButton(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset('assets/image/signButton.png'),
  );
}
