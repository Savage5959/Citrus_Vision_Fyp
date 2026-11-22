import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Camera and Gallery action buttons with circular containers and "or" divider.
class CameraGalleryActions extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const CameraGalleryActions({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // "or" Divider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 14.0),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  color: AppColors.divider,
                  thickness: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  'or',
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  color: AppColors.divider,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
        ),

        // Action Buttons: Open Camera and From Gallery
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.camera_alt_outlined,
                label: 'Open Camera',
                onTap: onCameraTap,
              ),
              _buildActionButton(
                icon: Icons.image_outlined,
                label: 'From Gallery',
                onTap: onGalleryTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circular container
            Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                color: AppColors.actionButtonBg,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.primaryGreen,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Label
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
