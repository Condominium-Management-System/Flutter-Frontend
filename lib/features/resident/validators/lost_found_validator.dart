
class LostFoundValidator {
  // ITEM NAME VALIDATION
  static String? validateItemName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Item name is required.';
    }

    final trimmed = value.trim();
    if (trimmed.length < 2) {
      return 'Item name must be at least 2 characters.';
    }

    if (trimmed.length > 50) {
      return 'Item name must be less than 50 characters.';
    }

    return null;
  }

  // DESCRIPTION VALIDATION
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required.';
    }

    final trimmed = value.trim();
    if (trimmed.length < 5) {
      return 'Please provide more details (minimum 5 characters).';
    }

    if (trimmed.length > 500) {
      return 'Description must be less than 500 characters.';
    }

    return null;
  }

  // CATEGORY VALIDATION
  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category.';
    }

    final validCategories = [
      'electronics',
      'documents',
      'keys',
      'clothing',
      'jewelry',
      'other',
    ];

    if (!validCategories.contains(value)) {
      return 'Invalid category selected.';
    }

    return null;
  }

  // TYPE VALIDATION
  static String? validateType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select lost or found.';
    }

    if (value != 'lost' && value != 'found') {
      return 'Invalid type selected.';
    }

    return null;
  }

  // LOCATION VALIDATION (Optional)
  static String? validateLocation(String? value) {
    // Location is optional but if provided, must be valid
    if (value != null && value.isNotEmpty) {
      final trimmed = value.trim();
      if (trimmed.length < 2) {
        return 'Location must be at least 2 characters.';
      }
      if (trimmed.length > 100) {
        return 'Location must be less than 100 characters.';
      }
    }
    return null;
  }

  // DATE VALIDATION
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required.';
    }

    // Check if date is valid ISO format
    try {
      final date = DateTime.parse(value);
      if (date.isAfter(DateTime.now())) {
        return 'Date cannot be in the future.';
      }
      return null;
    } catch (_) {
      return 'Invalid date format. Please use YYYY-MM-DD.';
    }
  }

  
  // CLAIM DESCRIPTION VALIDATION
  static String? validateClaimDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please provide a reason for claiming this item.';
    }

    final trimmed = value.trim();
    if (trimmed.length < 5) {
      return 'Please provide more details (minimum 5 characters).';
    }

    if (trimmed.length > 200) {
      return 'Description must be less than 200 characters.';
    }

    return null;
  }

  // PHOTO VALIDATION (Optional)
  static String? validatePhoto(String? value) {
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