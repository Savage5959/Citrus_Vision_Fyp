import 'package:flutter/material.dart';

/// Supported application languages.
class AppLanguages {
  static const String english = 'English';
  static const String spanish = 'Spanish';
  static const String urdu = 'Urdu';
  static const String arabic = 'Arabic';

  static const List<String> all = [
    english,
    spanish,
    urdu,
    arabic,
  ];
}

/// Global language state and translation service for Orange Detector.
class LanguageService extends ChangeNotifier {
  static final LanguageService _instance = LanguageService._internal();
  static LanguageService get instance => _instance;

  LanguageService._internal();

  String _currentLanguage = AppLanguages.english;

  String get currentLanguage => _currentLanguage;

  /// Changes the application language and notifies all listening widgets.
  void setLanguage(String language) {
    if (_currentLanguage != language && AppLanguages.all.contains(language)) {
      _currentLanguage = language;
      notifyListeners();
    }
  }

  /// Returns true if the current language is written Right-to-Left (Urdu, Arabic).
  bool get isRtl =>
      _currentLanguage == AppLanguages.urdu ||
      _currentLanguage == AppLanguages.arabic;

  /// Returns the text direction appropriate for the active language.
  TextDirection get textDirection =>
      isRtl ? TextDirection.rtl : TextDirection.ltr;

  /// Returns the Flutter Locale object.
  Locale get currentLocale {
    switch (_currentLanguage) {
      case AppLanguages.spanish:
        return const Locale('es');
      case AppLanguages.urdu:
        return const Locale('ur');
      case AppLanguages.arabic:
        return const Locale('ar');
      case AppLanguages.english:
      default:
        return const Locale('en');
    }
  }

  /// Translates a key according to the active language.
  String tr(String key) {
    final Map<String, String>? langMap = _translations[_currentLanguage];
    if (langMap != null && langMap.containsKey(key)) {
      return langMap[key]!;
    }
    // Fallback to English
    return _translations[AppLanguages.english]?[key] ?? key;
  }

  /// Static helper for convenience: `LanguageService.t('key')`
  static String t(String key) => _instance.tr(key);

  // Translation Dictionaries
  static final Map<String, Map<String, String>> _translations = {
    // ----------------- ENGLISH -----------------
    AppLanguages.english: {
      'app_name': 'Orange Detector',
      'app_subtitle': 'Orange Detection & Counting System',
      'hello_farmer': 'Hello Farmer! 👋',
      'tree_subtitle': "Let's check how many\noranges are on your tree.",
      'upload_image': 'Upload Image',
      'choose_from_gallery': 'Choose from gallery\nor take a photo',
      'open_camera': 'Open Camera',
      'from_gallery': 'From Gallery',
      'or': 'or',
      'home': 'Home',
      'history': 'History',
      'help': 'Help',
      'settings': 'Settings',
      'app_language': 'App Language',
      'about_app': 'About App',
      'model_info': 'Model Info',
      'clear_history': 'Clear History',
      'privacy_policy': 'Privacy Policy',
      'terms_conditions': 'Terms & Conditions',
      'version_title': 'Orange Detector v1.0',
      'slogan': 'Smart Farming. Better Harvest.',
      'get_started': 'Get Started',
      'select_language': 'Select App Language',
      'language_changed': 'Language changed to English',
      'close': 'Close',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'clear': 'Clear',
      'clear_history_confirm': 'Are you sure you want to clear all detection logs?',
      'history_cleared': 'Detection history cleared successfully',
      'notifications': 'Notifications',
      'no_notifications': 'No New Notifications',
      'all_caught_up': "You're all caught up! Updates and alerts will appear here.",
      'image_preview': 'Image Preview',
      'run_detection': 'Run Detection',
      'image_ready': 'Image ready for orange detection and counting',
      'retake_photo': 'Retake Photo',
      'choose_another': 'Choose Another',
      'detection_history_title': 'Detection History',
      'detection_history_desc': 'Your past tree scans, detected orange counts, and date logs will appear here.',
      'help_guide_title': 'Help & Guide',
      'help_guide_desc': 'Learn how to take optimal tree photos for accurate orange detection.',
      'about_project': 'About Project',
      'ai_model_details': 'AI Model Info',
      'yolo_architecture': 'YOLO Deep Learning Architecture',
    },

    // ----------------- SPANISH (Español) -----------------
    AppLanguages.spanish: {
      'app_name': 'Orange Detector',
      'app_subtitle': 'Sistema de Detección y Conteo de Naranjas',
      'hello_farmer': '¡Hola Agricultor! 👋',
      'tree_subtitle': 'Revisemos cuántas\nnaranjas hay en tu árbol.',
      'upload_image': 'Subir Imagen',
      'choose_from_gallery': 'Elige de la galería\no toma una foto',
      'open_camera': 'Abrir Cámara',
      'from_gallery': 'De la Galería',
      'or': 'o',
      'home': 'Inicio',
      'history': 'Historial',
      'help': 'Ayuda',
      'settings': 'Ajustes',
      'app_language': 'Idioma de la App',
      'about_app': 'Acerca de la App',
      'model_info': 'Info del Modelo',
      'clear_history': 'Borrar Historial',
      'privacy_policy': 'Política de Privacidad',
      'terms_conditions': 'Términos y Condiciones',
      'version_title': 'Orange Detector v1.0',
      'slogan': 'Agricultura Inteligente. Mejor Cosecha.',
      'get_started': 'Comenzar',
      'select_language': 'Seleccionar Idioma de la App',
      'language_changed': 'Idioma cambiado a Español',
      'close': 'Cerrar',
      'cancel': 'Cancelar',
      'confirm': 'Confirmar',
      'clear': 'Borrar',
      'clear_history_confirm': '¿Estás seguro de que deseas borrar todos los registros de detección?',
      'history_cleared': 'Historial de detección borrado con éxito',
      'notifications': 'Notificaciones',
      'no_notifications': 'Sin Notificaciones Nuevas',
      'all_caught_up': '¡Estás al día! Las actualizaciones y alertas aparecerán aquí.',
      'image_preview': 'Vista Previa de la Imagen',
      'run_detection': 'Ejecutar Detección',
      'image_ready': 'Imagen lista para detección y conteo de naranjas',
      'retake_photo': 'Tomar Otra Foto',
      'choose_another': 'Elegir Otra',
      'detection_history_title': 'Historial de Detección',
      'detection_history_desc': 'Tus escaneos anteriores, conteos de naranjas y registros de fecha aparecerán aquí.',
      'help_guide_title': 'Guía y Ayuda',
      'help_guide_desc': 'Aprende cómo tomar fotos óptimas para una detección precisa.',
      'about_project': 'Acerca del Proyecto',
      'ai_model_details': 'Info del Modelo IA',
      'yolo_architecture': 'Arquitectura de Aprendizaje Profundo YOLO',
    },

    // ----------------- URDU (اردو) -----------------
    AppLanguages.urdu: {
      'app_name': 'اورنج ڈٹیکٹر',
      'app_subtitle': 'مالٹے کی شناخت اور گنتی کا خودکار نظام',
      'hello_farmer': 'ہیلو کسان بھائی! 👋',
      'tree_subtitle': 'آئیے دیکھتے ہیں کہ آپ کے\nدرخت پر کتنے مالٹے ہیں۔',
      'upload_image': 'تصویر اپ لوڈ کریں',
      'choose_from_gallery': 'گیلری سے منتخب کریں\nیا تصویر بنائیں',
      'open_camera': 'کیمرہ کھولیں',
      'from_gallery': 'گیلری سے لیں',
      'or': 'یا',
      'home': 'ہوم',
      'history': 'تاریخ',
      'help': 'رہنمائی',
      'settings': 'سیٹنگز',
      'app_language': 'ایپ کی زبان',
      'about_app': 'ایپ کے بارے میں',
      'model_info': 'ماڈل کی معلومات',
      'clear_history': 'تاریخ صاف کریں',
      'privacy_policy': 'رازداری کی پالیسی',
      'terms_conditions': 'شرائط و ضوابط',
      'version_title': 'اورنج ڈٹیکٹر v1.0',
      'slogan': 'سمارٹ کاشتکاری۔ شاندار فصل۔',
      'get_started': 'شروع کریں',
      'select_language': 'ایپ کی زبان منتخب کریں',
      'language_changed': 'زبان اردو میں تبدیل ہو گئی ہے',
      'close': 'بند کریں',
      'cancel': 'منسوخ',
      'confirm': 'تصدیق کریں',
      'clear': 'صاف کریں',
      'clear_history_confirm': 'کیا آپ واقعی شناخت کی تمام تاریخ مٹانا چاہتے ہیں؟',
      'history_cleared': 'شناخت کی تاریخ کامیابی سے صاف کر دی گئی',
      'notifications': 'اطلاعات',
      'no_notifications': 'کوئی نئی اطلاع نہیں ہے',
      'all_caught_up': 'آپ مکمل طور پر باخبر ہیں! نئی اپ ڈیٹس یہاں ظاہر ہوں گی۔',
      'image_preview': 'تصویر کا پیش نظارہ',
      'run_detection': 'شناخت شروع کریں',
      'image_ready': 'مالٹے کی شناخت اور گنتی کے لیے تصویر تیار ہے',
      'retake_photo': 'دوبارہ تصویر لیں',
      'choose_another': 'دوسری منتخب کریں',
      'detection_history_title': 'شناخت کی تاریخ',
      'detection_history_desc': 'آپ کے پچھلے درختوں کے اسکین اور مالٹوں کی گنتی یہاں نظر آئے گی۔',
      'help_guide_title': 'رہنمائی اور مدد',
      'help_guide_desc': 'درست نتائج کے لیے درخت کی بہترین تصویر کھینچنے کا طریقہ سیکھیں۔',
      'about_project': 'پروجیکٹ کا تعارف',
      'ai_model_details': 'اے آئی ماڈل کی تفصیلات',
      'yolo_architecture': 'وائی او ایل او ڈیپ لرننگ ماڈل',
    },

    // ----------------- ARABIC (العربية) -----------------
    AppLanguages.arabic: {
      'app_name': 'كاشف البرتقال',
      'app_subtitle': 'نظام الكشف عن البرتقال وعدّه الذكي',
      'hello_farmer': 'مرحباً يا مزارع! 👋',
      'tree_subtitle': 'دعنا نتحقق من عدد\nالبرتقال على شجرتك.',
      'upload_image': 'تحميل الصورة',
      'choose_from_gallery': 'اختر من المعرض\nأو التقط صورة',
      'open_camera': 'فتح الكاميرا',
      'from_gallery': 'من المعرض',
      'or': 'أو',
      'home': 'الرئيسية',
      'history': 'السجل',
      'help': 'المساعدة',
      'settings': 'الإعدادات',
      'app_language': 'لغة التطبيق',
      'about_app': 'حول التطبيق',
      'model_info': 'معلومات النموذج',
      'clear_history': 'مسح السجل',
      'privacy_policy': 'سياسة الخصوصية',
      'terms_conditions': 'الشروط والأحكام',
      'version_title': 'كاشف البرتقال v1.0',
      'slogan': 'زراعة ذكية. حصاد أفضل.',
      'get_started': 'ابدأ الآن',
      'select_language': 'اختر لغة التطبيق',
      'language_changed': 'تم تغيير لغة التطبيق إلى العربية',
      'close': 'إغلاق',
      'cancel': 'إلغاء',
      'confirm': 'تأكيد',
      'clear': 'مسح',
      'clear_history_confirm': 'هل أنت متأكد من رغبتك في مسح جميع سجلات الكشف؟',
      'history_cleared': 'تم مسح سجل الكشف بنجاح',
      'notifications': 'الإشعارات',
      'no_notifications': 'لا توجد إشعارات جديدة',
      'all_caught_up': 'أنت مطلع على كل شيء! ستظهر التنبيهات هنا.',
      'image_preview': 'معاينة الصورة',
      'run_detection': 'تشغيل الكشف',
      'image_ready': 'الصورة جاهزة لكشف وعد البرتقال',
      'retake_photo': 'إعادة التقاط الصورة',
      'choose_another': 'اختيار صورة أخرى',
      'detection_history_title': 'سجل الكشف',
      'detection_history_desc': 'ستظهر هنا سجلات فحص الأشجار السابقة وعدد البرتقال المكتشف.',
      'help_guide_title': 'المساعدة والدليل',
      'help_guide_desc': 'تعلم كيفية التقاط صور مثالية للحصول على كشف دقيق.',
      'about_project': 'حول المشروع',
      'ai_model_details': 'معلومات نموذج الذكاء الاصطناعي',
      'yolo_architecture': 'هندسة التعلم العميق YOLO',
    },
  };
}
