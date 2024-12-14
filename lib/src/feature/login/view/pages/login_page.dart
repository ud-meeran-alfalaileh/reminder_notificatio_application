import 'package:flutter/material.dart';

import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/feature/login/view/widgte/main_widget/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: const LoginWidget(),
    );
  }
}
