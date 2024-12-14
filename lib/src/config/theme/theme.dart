import 'package:flutter/material.dart';

import 'app_extension.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    extensions: [
      lightAppColors,
    ],
  );

  static final lightAppColors = AppColorsExtension(
    primary: const Color(0xff3F9FD7), //
    background: const Color(0xff2C343C), //
    black: const Color(0xff000000), //
    maincolor: const Color(0xffFAF7F0), //
    bordercolor: const Color(0xffdddddd),
    subTextcolor: const Color(0xff6B7280),
    mainTextcolor: const Color(0xffFFFFFF),
    thirdTextcolor: const Color(0xff1363C6),
    containercolor: const Color(0xffECDEC7),
    secondaryColor: const Color(0xffFF6260),
  );
}
