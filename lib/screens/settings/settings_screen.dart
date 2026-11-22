import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Full Settings screen matching Screen 7 from the approved reference UI specification.
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
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
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
                      title: 'App Language',
                      trailingText: _selectedLanguage,
                      onTap: () => _showLanguageDialog(context),
                    ),
                    const _SettingsDivider(),

                    // 2. About App
                    _buildSettingsTile(
                      icon: Icons.info_outline_rounded,
                      title: 'About App',
                      onTap: () => _showAboutAppDialog(context),
                    ),
                    const _SettingsDivider(),

                    // 3. Model Info
                    _buildSettingsTile(
                      icon: Icons.hub_outlined,
                      title: 'Model Info',
                      onTap: () => _showModelInfoDialog(context),
                    ),
                    const _SettingsDivider(),

                    // 4. Clear History
                    _buildSettingsTile(
                      icon: Icons.delete_outline_rounded,
                      title: 'Clear History',
                      onTap: () => _showClearHistoryDialog(context),
                    ),
                    const _SettingsDivider(),

                    // 5. Privacy Policy
                    _buildSettingsTile(
                      icon: Icons.shield_outlined,
                      title: 'Privacy Policy',
                      onTap: () => _showPrivacyPolicyDialog(context),
                    ),
                    const _SettingsDivider(),

                    // 6. Terms & Conditions
                    _buildSettingsTile(
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
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
                    const Text(
                      'Orange Detector v1.0',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),

                    // Slogan
                    const Text(
                      'Smart Farming. Better Harvest.',
                      style: TextStyle(
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
    final List<String> languages = ['English', 'Spanish', 'Urdu', 'Arabic'];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select App Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) {
            final bool isSelected = _selectedLanguage == lang;
            return ListTile(
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
                setState(() {
                  _selectedLanguage = lang;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showAboutAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Text('🍊'),
            SizedBox(width: 8),
            Text('About App'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orange Detection and Counting System',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 8),
            Text(
              'Final Year Project (FYP) developed using Flutter & Android Studio.\n\nDesigned to empower orchard growers and agricultural researchers to automatically detect, estimate, and count ripe oranges directly on trees with deep learning precision.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
            SizedBox(height: 12),
            Text(
              'Version: 1.0.0 (Release Build)',
              style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showModelInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.hub_outlined, color: AppColors.primaryGreen),
            SizedBox(width: 8),
            Text('AI Model Info'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deep Learning Architecture: YOLO',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              '• Target Class: Orange fruit (Citrus sinensis)\n'
              '• Input Resolution: 640 x 640 px\n'
              '• Pipeline: Real-time object localization, bounding box regression & counting\n'
              '• Model Training: In progress (separate pipeline)\n'
              '• Integration: On-device TFLite / REST inference API ready',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Scan History?'),
        content: const Text(
          'Are you sure you want to delete all saved orange detection scans and logs?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scan history cleared successfully')),
              );
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Your orchard images and tree inspection photos are processed locally on your device for orange detection and counting.\n\nNo photos or personal farmer data are transmitted to third-party tracking services without explicit authorization.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Understood'),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms & Conditions'),
        content: const SingleChildScrollView(
          child: Text(
            'Orange Detector provides automated visual fruit count estimations intended to assist agricultural harvest planning.\n\nEnvironmental factors such as heavy foliage occlusion, low lighting, or extreme camera angles may affect fruit visibility.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
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
      color: Color(0xFFF3F4F6),
      indent: 18,
      endIndent: 18,
    );
  }
}
