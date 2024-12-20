import 'package:flutter/material.dart';
import 'package:time_async/src/config/theme/theme.dart';

class HomeText {
  static mainText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 24,
        color: AppTheme.lightAppColors.mainTextcolor,
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static secText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 40,
        color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.5),
        fontWeight: FontWeight.w300, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static titlText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 20,
        color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.7),
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static titlShowText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 16,
        color: AppTheme.lightAppColors.mainTextcolor,
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static descriptionShowTitle(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 13,
        color: AppTheme.lightAppColors.mainTextcolor,
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static notificationText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 17,
        color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.8),
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static chatText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 15,
        color: AppTheme.lightAppColors.black,
        fontWeight: FontWeight.w300, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static headerText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 17,
        color: AppTheme.lightAppColors.black,
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }
}
