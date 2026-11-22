import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Top App Header with Hamburger menu on left and Notification bell on right.
class AppHeader extends StatelessWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onNotificationPressed;

  const AppHeader({
    super.key,
    required this.onMenuPressed,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hamburger Menu Button
          IconButton(
            onPressed: onMenuPressed,
            icon: const Icon(
              Icons.menu_rounded,
              color: AppColors.textDark,
              size: 26,
            ),
            splashRadius: 24,
            tooltip: 'Navigation Menu',
          ),

          // Notification Bell Button
          IconButton(
            onPressed: onNotificationPressed,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.textDark,
              size: 26,
            ),
            splashRadius: 24,
            tooltip: 'Notifications',
          ),
        ],
      ),
    );
  }
}
