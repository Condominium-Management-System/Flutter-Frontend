
// Export all validators
import 'package:home_axis/features/resident/validators/equb_validator.dart';
import 'package:home_axis/features/resident/validators/lost_found_validator.dart';
import 'package:home_axis/features/resident/validators/payment_validator.dart';
import 'package:home_axis/features/resident/validators/report_validator.dart';

export 'payment_validator.dart';
export 'report_validator.dart';
export 'lost_found_validator.dart';
export 'equb_validator.dart';

// RESIDENT VALIDATION COMBINED CLASS

class ResidentValidators {
  // Payment
  static String? validateAmount(String? value) =>
      PaymentValidator.validateAmount(value);

  static String? validatePaymentType(String? value) =>
      PaymentValidator.validatePaymentType(value);

  static String? validatePaymentMethod(String? value) =>
      PaymentValidator.validatePaymentMethod(value);

  static String? validateMonthYear(String? value) =>
      PaymentValidator.validateMonthYear(value);

  // Report
  static String? validateReportTitle(String? value) =>
      ReportValidator.validateTitle(value);

  static String? validateReportDescription(String? value) =>
      ReportValidator.validateDescription(value);

  static String? validateReportCategory(String? value) =>
      ReportValidator.validateCategory(value);

  static String? validateReportPriority(String? value) =>
      ReportValidator.validatePriority(value);

  // Lost & Found
  static String? validateItemName(String? value) =>
      LostFoundValidator.validateItemName(value);

  static String? validateLostFoundDescription(String? value) =>
      LostFoundValidator.validateDescription(value);

  static String? validateLostFoundCategory(String? value) =>
      LostFoundValidator.validateCategory(value);

  static String? validateLostFoundType(String? value) =>
      LostFoundValidator.validateType(value);

  static String? validateLostFoundDate(String? value) =>
      LostFoundValidator.validateDate(value);

  static String? validateClaimDescription(String? value) =>
      LostFoundValidator.validateClaimDescription(value);

  // Equb / Iddir
  static String? validateGroupName(String? value) =>
      EqubValidator.validateGroupName(value);

  static String? validateContributionAmount(String? value) =>
      EqubValidator.validateContributionAmount(value);

  static String? validateStartDate(String? value) =>
      EqubValidator.validateStartDate(value);

  static String? validateEndDate(String? value, {String? startDate}) =>
      EqubValidator.validateEndDate(value, startDate);

  static String? validateMemberCount(String? value) =>
      EqubValidator.validateMemberCount(value);

  // Combined validation helpers
  static bool isPaymentValid({
    required String? amount,
    required String? paymentType,
    required String? paymentMethod,
  }) {
    return validateAmount(amount) == null &&
        validatePaymentType(paymentType) == null &&
        validatePaymentMethod(paymentMethod) == null;
  }

  static bool isReportValid({
    required String? title,
    required String? description,
    required String? category,
    required String? priority,
  }) {
    return validateReportTitle(title) == null &&
        validateReportDescription(description) == null &&
        validateReportCategory(category) == null &&
        validateReportPriority(priority) == null;
  }

  static bool isLostFoundValid({
    required String? itemName,
    required String? description,
    required String? category,
    required String? type,
    required String? date,
  }) {
    return validateItemName(itemName) == null &&
        validateLostFoundDescription(description) == null &&
        validateLostFoundCategory(category) == null &&
        validateLostFoundType(type) == null &&
        validateLostFoundDate(date) == null;
  }
}