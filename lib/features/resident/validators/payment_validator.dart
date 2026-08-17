
class PaymentValidator {
  // AMOUNT VALIDATION
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required.';
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

  // PAYMENT TYPE VALIDATION
  static String? validatePaymentType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a payment type.';
    }

    final validTypes = [
      'iddir',
      'equb',
      'guard_fee',
      'service_charge',
      'other',
    ];

    if (!validTypes.contains(value)) {
      return 'Invalid payment type.';
    }

    return null;
  }

  // PAYMENT METHOD VALIDATION
  static String? validatePaymentMethod(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a payment method.';
    }

    final validMethods = [
      'cbe',
      'telebirr',
      'cash',
      'bank_transfer',
      'card',
      'chapa',
    ];

    if (!validMethods.contains(value)) {
      return 'Invalid payment method.';
    }

    return null;
  }

  // MONTH/YEAR VALIDATION
  static String? validateMonthYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a month and year.';
    }

    // Check format MM-YYYY
    final regex = RegExp(r'^(0[1-9]|1[0-2])-(20[2-9][0-9])$');
    if (!regex.hasMatch(value)) {
      return 'Invalid month/year format. Use MM-YYYY.';
    }

    return null;
  }

  // RECEIPT VALIDATION (Optional)
  static String? validateReceipt(String? value) {
    // Receipt is optional in most cases
    if (value != null && value.isNotEmpty) {
      final validExtensions = ['.jpg', '.jpeg', '.png', '.pdf'];
      final extension = value.toLowerCase();
      if (!validExtensions.any((ext) => extension.endsWith(ext))) {
        return 'Receipt must be an image or PDF.';
      }
    }
    return null;
  }

  // CHAPA PAYMENT VALIDATION
  static String? validateReturnUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Return URL is required for Chapa payments.';
    }

    // Basic URL validation
    final urlRegex = RegExp(
      r'^https?://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(?:/[^\s]*)?$',
    );
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid return URL.';
    }

    return null;
  }
}