import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/theme/app_colors.dart';
import '../../services/image_picker_service.dart';
import '../../services/language_service.dart';
import '../../widgets/common/app_bottom_navigation.dart';
import '../../widgets/common/app_drawer.dart';
import '../../widgets/common/app_header.dart';
import '../../widgets/home/camera_gallery_actions.dart';
import '../../widgets/home/orchard_visual.dart';
import '../../widgets/home/upload_section.dart';
import '../notifications/notifications_screen.dart';
import '../placeholder/placeholder_tab_screen.dart';
import '../preview/preview_image_screen.dart';
import '../settings/settings_screen.dart';

/// Main Home Screen reproducing the approved reference UI.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePickerService _pickerService = ImagePickerService();
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageService.instance,
      builder: (context, _) {
        final language = LanguageService.instance;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppColors.background,
          drawer: AppDrawer(
            selectedIndex: _currentTabIndex,
            onSelectTab: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Top App Bar / Header (Shown on Home Tab)
                if (_currentTabIndex == 0)
                  AppHeader(
                    onMenuPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    onNotificationPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),

                // Tab Content
                Expanded(
                  child: IndexedStack(
                    index: _currentTabIndex,
                    children: [
                      _buildHomeContent(language),
                      PlaceholderTabScreen(
                        title: language.tr('detection_history_title'),
                        icon: Icons.access_time_rounded,
                        description: language.tr('detection_history_desc'),
                      ),
                      PlaceholderTabScreen(
                        title: language.tr('help_guide_title'),
                        icon: Icons.help_outline_rounded,
                        description: language.tr('help_guide_desc'),
                      ),
                      const SettingsScreen(showBackButton: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: AppBottomNavigation(
            currentIndex: _currentTabIndex,
            onTap: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
          ),
        );
      },
    );
  }

  /// Builds the Home Screen content matching the reference image.
  Widget _buildHomeContent(LanguageService language) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),

                  // Greeting Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          language.tr('hello_farmer'),
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          language.tr('tree_subtitle'),
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 14,
                            height: 1.35,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Orchard Visual Illustration
                  const OrchardVisual(),
                  const SizedBox(height: 14),

                  // Main Upload Card
                  UploadSection(
                    onTap: () => _showUploadOptionsBottomSheet(context),
                  ),

                  // "or" Divider and Camera/Gallery Actions
                  CameraGalleryActions(
                    onCameraTap: () => _pickImage(ImageSource.camera),
                    onGalleryTap: () => _pickImage(ImageSource.gallery),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Shows options to capture from camera, choose from gallery, or test sample.
  void _showUploadOptionsBottomSheet(BuildContext context) {
    final language = LanguageService.instance;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  language.tr('upload_image'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.actionButtonBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  title: Text(language.tr('open_camera')),
                  subtitle: Text(language.tr('choose_from_gallery')),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.actionButtonBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.image_outlined,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  title: Text(language.tr('from_gallery')),
                  subtitle: Text(language.tr('choose_from_gallery')),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.actionButtonBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.photo_library_outlined,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  title: const Text('Use Reference Sample'),
                  subtitle: const Text('Load sample orange tree for testing'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _navigateToPreview(
                      'assets/images/sample_orange_tree.png',
                      isAsset: true,
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Handles picking/capturing image with error and cancellation handling.
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? file = source == ImageSource.camera
          ? await _pickerService.captureImageFromCamera()
          : await _pickerService.pickImageFromGallery();

      if (file != null && mounted) {
        _navigateToPreview(file.path, isAsset: false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not access ${source == ImageSource.camera ? "camera" : "gallery"}: $e',
            ),
            backgroundColor: Colors.redAccent,
            action: SnackBarAction(
              label: 'Sample Photo',
              textColor: Colors.white,
              onPressed: () {
                _navigateToPreview(
                  'assets/images/sample_orange_tree.png',
                  isAsset: true,
                );
              },
            ),
          ),
        );
      }
    }
  }

  void _navigateToPreview(String imagePath, {required bool isAsset}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewImageScreen(
          imagePath: imagePath,
          isAsset: isAsset,
        ),
      ),
    );
  }
}
