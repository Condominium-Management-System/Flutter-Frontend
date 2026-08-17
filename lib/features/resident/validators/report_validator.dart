
class ReportValidator {
  // TITLE VALIDATION
  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required.';
    }

    final trimmed = value.trim();
    if (trimmed.length < 3) {
      return 'Title must be at least 3 characters.';
    }

    if (trimmed.length > 100) {
      return 'Title must be less than 100 characters.';
    }

    return null;
  }

  // DESCRIPTION VALIDATION
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required.';
    }

    final trimmed = value.trim();
    if (trimmed.length < 10) {
      return 'Please provide more details (minimum 10 characters).';
    }

    if (trimmed.length > 1000) {
      return 'Description must be less than 1000 characters.';
    }

    return null;
  }

  // CATEGORY VALIDATION
  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category.';
    }

    final validCategories = [
      'plumbing',
      'electrical',
      'structural',
      'security',
      'noise',
      'other',
    ];

    if (!validCategories.contains(value)) {
      return 'Invalid category selected.';
    }

    return null;
  }

  // PRIORITY VALIDATION
  static String? validatePriority(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a priority level.';
    }

    final validPriorities = [
      'low',
      'medium',
      'high',
      'emergency',
    ];

    if (!validPriorities.contains(value)) {
      return 'Invalid priority selected.';
    }

    return null;
  }

  // PHOTO VALIDATION (Optional)
  static String? validatePhoto(String? value) {
    // Photo is optional
    if (value != null && value.isNotEmpty) {
      final validExtensions = ['.jpg', '.jpeg', '.png', '.heic'];
      final extension = value.toLowerCase();
      if (!validExtensions.any((ext) => extension.endsWith(ext))) {
        return 'Photo must be an image (JPG, PNG, HEIC).';
      }
    }
    return null;
  }
}