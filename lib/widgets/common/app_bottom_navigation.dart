import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../services/language_service.dart';

/// Bottom Navigation Bar with 4 items: Home, History, Help, Settings.
/// Exactly matching the reference image and reacting to language changes.
class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final language = LanguageService.instance;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceWhite,
        border: Border(
          top: BorderSide(
            color: AppColors.navBorder,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.home_rounded,
                label: language.tr('home'),
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.access_time_rounded,
                label: language.tr('history'),
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.help_outline_rounded,
                label: language.tr('help'),
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.settings_outlined,
                label: language.tr('settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = currentIndex == index;
    final Color itemColor =
        isSelected ? AppColors.primaryGreen : AppColors.navInactive;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: itemColor,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: itemColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
