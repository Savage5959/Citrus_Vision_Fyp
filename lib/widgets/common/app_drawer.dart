import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../services/language_service.dart';

/// Functional Navigation Drawer for the Orange Detection app.
class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelectTab;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelectTab,
  });

  @override
  Widget build(BuildContext context) {
    final language = LanguageService.instance;

    return Drawer(
      backgroundColor: AppColors.surfaceWhite,
      child: Column(
        children: [
          // Drawer Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 24,
              bottom: 24,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.cardGreenTop,
                  AppColors.cardGreenBottom,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      '🍊',
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  language.tr('app_name'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  language.tr('app_subtitle'),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Drawer Navigation List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: Icons.home_rounded,
                  title: language.tr('home'),
                  index: 0,
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.history_rounded,
                  title: language.tr('detection_history_title'),
                  index: 1,
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.help_outline_rounded,
                  title: language.tr('help_guide_title'),
                  index: 2,
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  title: language.tr('settings'),
                  index: 3,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.psychology_outlined,
                    color: AppColors.primaryGreen,
                  ),
                  title: Text(
                    language.tr('ai_model_details'),
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    language.tr('yolo_architecture'),
                    style: const TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showModelInfoDialog(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.textMuted,
                  ),
                  title: Text(
                    language.tr('about_project'),
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),
          ),

          // Footer
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${language.tr('version_title')} • ${language.tr('slogan')}',
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primaryGreen : AppColors.navInactive,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primaryGreen : AppColors.textDark,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      selected: isSelected,
      onTap: () {
        Navigator.pop(context);
        onSelectTab(index);
      },
    );
  }

  void _showModelInfoDialog(BuildContext context) {
    final language = LanguageService.instance;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(language.tr('ai_model_details')),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOLO Deep Learning Architecture',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Real-time object detection and counting pipeline specifically optimized for orchard tree foliage and fruit cluster identification.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(language.tr('close')),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final language = LanguageService.instance;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(language.tr('about_project')),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Final Year Project (FYP)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Orange Detection and Counting System Using Deep Learning.\n\n'
              'Developed using Flutter for Android Studio, integrated with advanced computer vision models.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(language.tr('close')),
          ),
        ],
      ),
    );
  }
}
