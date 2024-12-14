import 'package:flutter/material.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/feature/splash_screens/view/widgte/main_widget/splash_widget.dart';

class SpalshPage extends StatelessWidget {
  const SpalshPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: const SplashWidget(),
    );
  }
}
