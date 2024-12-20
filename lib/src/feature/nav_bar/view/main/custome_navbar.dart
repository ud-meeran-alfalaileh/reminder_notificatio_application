import 'package:flutter/material.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';

class CustomNavItem extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final bool isSelected;

  const CustomNavItem(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.isSelected,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: context.screenWidth * 0.2,
        height: context.screenHeight,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected
                ? AppTheme.lightAppColors.primary
                : AppTheme.lightAppColors.maincolor.withOpacity(.6),
            BlendMode.srcIn,
          ),
          child: icon,
        ),
      ),
    );
  }
}
