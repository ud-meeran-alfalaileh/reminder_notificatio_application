import 'package:flutter/material.dart';
import 'package:time_async/src/config/theme/theme.dart';

class VendorLoadingPage extends StatelessWidget {
  const VendorLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
