import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../services/language_service.dart';

/// Full Settings screen matching Screen 7 from the approved reference UI specification.
/// Fully integrated with LanguageService for real-time multilingual switching.
class SettingsScreen extends StatefulWidget {
  final bool showBackButton;

  const SettingsScreen({
    super.key,
    this.showBackButton = false,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageService.instance,
      builder: (context, _) {
        final language = LanguageService.instance;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text(
              language.tr('settings'),
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            leading: widget.showBackButton
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    onPressed: () => Navigator.pop(context),
                  )
                : null,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                children: [
                  // Settings Items Container
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // 1. App Language
                        _buildSettingsTile(
                          icon: Icons.language_rounded,
                          title: language.tr('app_language'),
                          trailingText: language.currentLanguage,
                          onTap: () => _showLanguageDialog(context),
                        ),
                        const _SettingsDivider(),

                        // 2. About App
                        _buildSettingsTile(
                          icon: Icons.info_outline_rounded,
                          title: language.tr('about_app'),
                          onTap: () => _showAboutAppDialog(context),
                        ),
                        const _SettingsDivider(),

                        // 3. Model Info
                        _buildSettingsTile(
                          icon: Icons.hub_outlined,
                          title: language.tr('model_info'),
                          onTap: () => _showModelInfoDialog(context),
                        ),
                        const _SettingsDivider(),

                        // 4. Clear History
                        _buildSettingsTile(
                          icon: Icons.delete_outline_rounded,
                          title: language.tr('clear_history'),
                          onTap: () => _showClearHistoryDialog(context),
                        ),
                        const _SettingsDivider(),

                        // 5. Privacy Policy
                        _buildSettingsTile(
                          icon: Icons.shield_outlined,
                          title: language.tr('privacy_policy'),
                          onTap: () => _showPrivacyPolicyDialog(context),
                        ),
                        const _SettingsDivider(),

                        // 6. Terms & Conditions
                        _buildSettingsTile(
                          icon: Icons.description_outlined,
                          title: language.tr('terms_conditions'),
                          onTap: () => _showTermsDialog(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Bottom Banner: "Orange Detector v1.0 • Smart Farming. Better Harvest."
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18.0,
                      horizontal: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2EFE0),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Twin green leaves icon
                        const Icon(
                          Icons.eco_rounded,
                          color: Color(0xFF2E7D32),
                          size: 26,
                        ),
                        const SizedBox(height: 8),

                        // Version Title
                        Text(
                          language.tr('version_title'),
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),

                        // Slogan
                        Text(
                          language.tr('slogan'),
                          style: const TextStyle(
                            color: Color(0xFF2E7D32),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.textDark,
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailingText != null) ...[
              Text(
                trailingText,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
            ],
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textLight,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final language = LanguageService.instance;
    final List<String> languages = AppLanguages.all;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          language.tr('select_language'),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) {
            final bool isSelected = language.currentLanguage == lang;
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                lang,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primaryGreen : AppColors.textDark,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryGreen)
                  : null,
              onTap: () {
                Navigator.pop(context);
                language.setLanguage(lang);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(language.tr('language_changed')),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showAboutAppDialog(BuildContext context) {
    final language = LanguageService.instance;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.eco_rounded, color: AppColors.primaryGreen, size: 28),
            const SizedBox(width: 10),
            Text(language.tr('app_name')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              language.tr('app_subtitle'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            const Text(
              'Final Year Project (FYP)\n'
              'Smart Agriculture & Deep Learning System.\n\n'
              'Automates orange detection, counting, and yield estimation in orchards using real-time computer vision.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.infoBoxBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Version: 1.0.0 (Release)\n'
                'Framework: Flutter 3.x / Dart 3.x',
                style: TextStyle(fontSize: 12, color: AppColors.primaryGreen, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(language.tr('close'), style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showModelInfoDialog(BuildContext context) {
    final language = LanguageService.instance;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.hub_outlined, color: AppColors.primaryGreen, size: 26),
            const SizedBox(width: 10),
            Text(language.tr('model_info')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              language.tr('yolo_architecture'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Object Detection: YOLO Neural Network\n'
              '• Task: Real-time Orange Detection & Counting\n'
              '• Target Environment: Natural Orchard Conditions\n'
              '• Inference: Ready for on-device TFLite / ONNX model integration',
              style: TextStyle(fontSize: 13, height: 1.45),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Note: Model weights are trained separately and will be connected for live inference.',
                style: TextStyle(fontSize: 12, color: Color(0xFFE65100)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(language.tr('close'), style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    final language = LanguageService.instance;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(language.tr('clear_history')),
        content: Text(language.tr('clear_history_confirm')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(language.tr('cancel'), style: const TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(language.tr('history_cleared')),
                  backgroundColor: AppColors.primaryGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: Text(language.tr('clear')),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    final language = LanguageService.instance;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(language.tr('privacy_policy')),
        content: const SingleChildScrollView(
          child: Text(
            'Your privacy is respected. Orange Detector processes orchard tree images strictly for detection and counting analysis.\n\n'
            '• Images selected or captured are processed locally.\n'
            '• No personal information or tree images are transmitted to external marketing servers.\n'
            '• Camera and storage permissions are used exclusively for image capture and analysis.',
            style: TextStyle(fontSize: 13, height: 1.45),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(language.tr('close'), style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    final language = LanguageService.instance;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(language.tr('terms_conditions')),
        content: const SingleChildScrollView(
          child: Text(
            'Terms & Conditions:\n\n'
            '1. This application is an academic Final Year Project designed for agricultural orchard assistance.\n'
            '2. Detection and counting results are provided to assist farmers in yield estimation.\n'
            '3. Always follow standard horticultural guidance in conjunction with automated detection figures.',
            style: TextStyle(fontSize: 13, height: 1.45),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(language.tr('close'), style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.divider,
      indent: 56,
      endIndent: 18,
    );
  }
}
