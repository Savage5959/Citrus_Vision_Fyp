import 'package:image_picker/image_picker.dart';

/// Service to handle picking images from gallery or capturing via device camera.
class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Pick an image from device gallery.
  /// Returns [XFile] if user selected an image, or `null` if cancelled.
  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 90,
      );
      return file;
    } catch (e) {
      // Permission denied or operation failed
      rethrow;
    }
  }

  /// Capture a new photo using device camera.
  /// Returns [XFile] if user captured a photo, or `null` if cancelled.
  Future<XFile?> captureImageFromCamera() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 90,
      );
      return file;
    } catch (e) {
      // Permission denied or operation failed
      rethrow;
    }
  }
}
