import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat transactionDateFormat = DateFormat('MMM dd, yyyy');
  static final DateFormat _transactionDateTimeFormat = DateFormat('MMM dd, yyyy • hh:mm a');
  static final DateFormat _fullDateTimeFormat = DateFormat('EEEE, MMMM dd, yyyy • hh:mm a');
  static final DateFormat timeOnlyFormat = DateFormat('hh:mm a');
  static final DateFormat _dateOnlyFormat = DateFormat('MMM dd, yyyy');

  /// Formats a date string for transaction detail display
  static String formatTransactionDateTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Unknown Date & Time';

    try {
      final date = DateTime.parse(dateString);
      return _transactionDateTimeFormat.format(date);
    } catch (e) {
      return 'Invalid Date & Time';
    }
  }

  /// Formats a date string for full detailed display
  static String formatFullDateTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Unknown Date & Time';

    try {
      final date = DateTime.parse(dateString);
      return _fullDateTimeFormat.format(date);
    } catch (e) {
      return 'Invalid Date & Time';
    }
  }

  /// Returns relative time string (e.g., "2 hours ago")
  static String getRelativeTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Unknown time';

    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown time';
    }
  }

  /// Formats date for API requests
  static String formatForApi(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Formats datetime for API requests
  static String formatDateTimeForApi(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
  }

  /// Checks if date is today
  static bool isToday(String? dateString) {
    if (dateString == null || dateString.isEmpty) return false;

    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      return date.year == now.year && date.month == now.month && date.day == now.day;
    } catch (e) {
      return false;
    }
  }

  /// Checks if date is this week
  static bool isThisWeek(String? dateString) {
    if (dateString == null || dateString.isEmpty) return false;

    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);
      return difference.inDays < 7 && difference.inDays >= 0;
    } catch (e) {
      return false;
    }
  }
}
