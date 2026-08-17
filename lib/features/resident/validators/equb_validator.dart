
class EqubValidator {
  // GROUP NAME VALIDATION
  static String? validateGroupName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Group name is required.';
    }

    final trimmed = value.trim();
    if (trimmed.length < 3) {
      return 'Group name must be at least 3 characters.';
    }

    if (trimmed.length > 50) {
      return 'Group name must be less than 50 characters.';
    }

    return null;
  }

  // CONTRIBUTION AMOUNT VALIDATION
  static String? validateContributionAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contribution amount is required.';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid amount.';
    }

    if (amount <= 0) {
      return 'Amount must be greater than 0.';
    }

    if (amount > 9999999) {
      return 'Amount is too large.';
    }

    return null;
  }

  // START DATE VALIDATION
  static String? validateStartDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Start date is required.';
    }

    try {
      final date = DateTime.parse(value);
      if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
        return 'Start date cannot be in the past.';
      }
      return null;
    } catch (_) {
      return 'Invalid date format. Please use YYYY-MM-DD.';
    }
  }

  // END DATE VALIDATION (For Equb)
  static String? validateEndDate(String? value, String? startDate) {
    if (value == null || value.isEmpty) {
      return 'End date is required.';
    }

    try {
      final endDate = DateTime.parse(value);
      
      if (startDate != null && startDate.isNotEmpty) {
        final start = DateTime.parse(startDate);
        if (endDate.isBefore(start)) {
          return 'End date must be after start date.';
        }
      }

      if (endDate.isBefore(DateTime.now())) {
        return 'End date cannot be in the past.';
      }

      return null;
    } catch (_) {
      return 'Invalid date format. Please use YYYY-MM-DD.';
    }
  }

  // MEMBER COUNT VALIDATION
  static String? validateMemberCount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number of members is required.';
    }

    final count = int.tryParse(value);
    if (count == null) {
      return 'Please enter a valid number.';
    }

    if (count < 2) {
      return 'Minimum 2 members required.';
    }

    if (count > 100) {
      return 'Maximum 100 members allowed.';
    }

    return null;
  }

  // IDDIR CONTRIBUTION VALIDATION
  static String? validateIddirAmount(String? value) {
    return validateContributionAmount(value);
  }
}