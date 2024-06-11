///Custom exception class to handle various format-related errors.
library;

class CSFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default Constructor with a generic error message.
  const CSFormatException([this.message = '']);

  /// Create a format exception from a specific error message.
  factory CSFormatException.fromMessage(String message) {
    return CSFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  ///Create a format exception from a specific error code.
  factory CSFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const CSFormatException(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const CSFormatException(
            'The provided phone number format is invalid. Please enter a valid number');
      case 'invalid-date-format':
        return const CSFormatException(
            'The date format is invalid. Please enter a valid date');
      case 'invalid-url-format':
        return const CSFormatException(
            'The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const CSFormatException(
            'The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const CSFormatException(
            'The input should be a valid numeric format.');
      // Add more cases as needed...
      default:
        return const CSFormatException(
            'An unexpected format error occurred. Please try again.');
    }
  }
}
