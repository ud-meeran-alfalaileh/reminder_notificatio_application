import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/theme/theme.dart';

class LoginText {
  static haveAccount(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(TextSpan(
          text: "Don’t have an account?".tr,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Inter',
            color: AppTheme.lightAppColors.mainTextcolor,
          ),
          children: [
            TextSpan(
              text: " Sign up".tr,
              style: TextStyle(
                fontSize: 15,
                color: AppTheme.lightAppColors.primary,
                fontFamily: 'Inter',
              ),
            )
          ])),
    );
  }

  static dontHaveAccount(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(TextSpan(
          text: "Have Account? ",
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Inter',
            color: AppTheme.lightAppColors.mainTextcolor,
          ),
          children: [
            TextSpan(
              text: "Sign In".tr,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.lightAppColors.primary,
                fontFamily: 'Inter',
              ),
            )
          ])),
    );
  }

  static mainText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 40,
        letterSpacing: 2,
        color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.8),
        fontWeight: FontWeight.w900, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static secText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: AppTheme.lightAppColors.subTextcolor,
        fontWeight: FontWeight.w500, // Use FontWeight.bold for the bold variant
      ),
    );
  }
}
