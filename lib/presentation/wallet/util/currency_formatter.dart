import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final Map<String, NumberFormat> _formatters = {};
  static final Map<String, NumberFormat> _compactFormatters = {};

  /// Formats amount with currency symbol
  static String format(double amount, String currencyCode) {
    try {
      final formatter = _getFormatter(currencyCode);
      return formatter.format(amount);
    } catch (e) {
      return '${getCurrencySymbol(currencyCode)} ${amount.toStringAsFixed(_getDecimalPlaces(currencyCode))}';
    }
  }

  /// Formats amount without currency symbol
  static String formatWithoutSymbol(double amount, {int decimalPlaces = 2}) {
    final formatter = NumberFormat('#,##0.${'0' * decimalPlaces}');
    return formatter.format(amount);
  }

  /// Formats amount for display in lists (compact format)
  static String formatCompact(double amount, String currencyCode) {
    try {
      final symbol = getCurrencySymbol(currencyCode);
      final absAmount = amount.abs();
      final isNegative = amount < 0;
      final prefix = isNegative ? '-' : '';

      if (absAmount >= 1000000000) {
        return '$prefix$symbol${(absAmount / 1000000000).toStringAsFixed(1)}B';
      } else if (absAmount >= 1000000) {
        return '$prefix$symbol${(absAmount / 1000000).toStringAsFixed(1)}M';
      } else if (absAmount >= 1000) {
        return '$prefix$symbol${(absAmount / 1000).toStringAsFixed(1)}K';
      } else {
        return format(amount, currencyCode);
      }
    } catch (e) {
      return format(amount, currencyCode);
    }
  }

  /// Advanced compact formatting with better precision
  static String formatCompactAdvanced(double amount, String currencyCode) {
    try {
      final symbol = getCurrencySymbol(currencyCode);
      final absAmount = amount.abs();
      final isNegative = amount < 0;
      final prefix = isNegative ? '-' : '';

      if (absAmount >= 1000000000) {
        final value = absAmount / 1000000000;
        final decimals = value >= 10 ? 1 : 2;
        return '$prefix$symbol${value.toStringAsFixed(decimals)}B';
      } else if (absAmount >= 1000000) {
        final value = absAmount / 1000000;
        final decimals = value >= 10 ? 1 : 2;
        return '$prefix$symbol${value.toStringAsFixed(decimals)}M';
      } else if (absAmount >= 1000) {
        final value = absAmount / 1000;
        final decimals = value >= 10 ? 1 : 2;
        return '$prefix$symbol${value.toStringAsFixed(decimals)}K';
      } else {
        return format(amount, currencyCode);
      }
    } catch (e) {
      return format(amount, currencyCode);
    }
  }

  /// Gets currency symbol for a currency code
  static String getCurrencySymbol(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'PKR':
        return 'Rs.';
      case 'INR':
        return '₹';
      case 'CNY':
        return '¥';
      case 'KRW':
        return '₩';
      case 'AUD':
        return 'A\$';
      case 'CAD':
        return 'C\$';
      case 'CHF':
        return 'Fr.';
      case 'SEK':
        return 'kr';
      case 'NOK':
        return 'kr';
      case 'DKK':
        return 'kr';
      case 'PLN':
        return 'zł';
      case 'CZK':
        return 'Kč';
      case 'HUF':
        return 'Ft';
      case 'RUB':
        return '₽';
      case 'BRL':
        return 'R\$';
      case 'MXN':
        return 'Mex\$';
      case 'SGD':
        return 'S\$';
      case 'HKD':
        return 'HK\$';
      case 'NZD':
        return 'NZ\$';
      case 'ZAR':
        return 'R';
      case 'TRY':
        return '₺';
      case 'ILS':
        return '₪';
      case 'AED':
        return 'د.إ';
      case 'SAR':
        return 'ر.س';
      case 'EGP':
        return 'ج.م';
      case 'THB':
        return '฿';
      case 'VND':
        return '₫';
      case 'IDR':
        return 'Rp';
      case 'MYR':
        return 'RM';
      case 'PHP':
        return '₱';
      case 'TWD':
        return 'NT\$';
      case 'CLP':
        return 'CLP\$';
      case 'COP':
        return 'COL\$';
      case 'PEN':
        return 'S/.';
      case 'UYU':
        return '\$U';
      case 'ARS':
        return 'AR\$';
      case 'KZT':
        return '₸';
      case 'UAH':
        return '₴';
      case 'BGN':
        return 'лв';
      case 'RON':
        return 'lei';
      case 'HRK':
        return 'kn';
      case 'ISK':
        return 'kr';
      case 'MAD':
        return 'د.م.';
      case 'TND':
        return 'د.ت';
      case 'JOD':
        return 'د.ا';
      case 'KWD':
        return 'د.ك';
      case 'BHD':
        return 'د.ب';
      case 'OMR':
        return 'ر.ع.';
      case 'QAR':
        return 'ر.ق';
      case 'LBP':
        return 'ل.ل';
      case 'SYP':
        return 'ل.س';
      case 'IQD':
        return 'ع.د';
      case 'IRR':
        return '﷼';
      case 'AFN':
        return '؋';
      case 'BDT':
        return '৳';
      case 'BTN':
        return 'Nu.';
      case 'LKR':
        return 'Rs';
      case 'MVR':
        return 'Rf';
      case 'NPR':
        return 'Rs';
      case 'LAK':
        return '₭';
      case 'KHR':
        return '៛';
      case 'MMK':
        return 'K';
      case 'BND':
        return 'B\$';
      case 'FJD':
        return 'FJ\$';
      case 'PGK':
        return 'K';
      case 'SBD':
        return 'SI\$';
      case 'TOP':
        return 'T\$';
      case 'VUV':
        return 'VT';
      case 'WST':
        return 'WS\$';
      default:
        return currencyCode.toUpperCase();
    }
  }

  /// Gets currency name for a currency code
  static String getCurrencyName(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
        return 'US Dollar';
      case 'EUR':
        return 'Euro';
      case 'GBP':
        return 'British Pound Sterling';
      case 'JPY':
        return 'Japanese Yen';
      case 'PKR':
        return 'Pakistani Rupee';
      case 'INR':
        return 'Indian Rupee';
      case 'CNY':
        return 'Chinese Yuan';
      case 'KRW':
        return 'South Korean Won';
      case 'AUD':
        return 'Australian Dollar';
      case 'CAD':
        return 'Canadian Dollar';
      case 'CHF':
        return 'Swiss Franc';
      case 'SEK':
        return 'Swedish Krona';
      case 'NOK':
        return 'Norwegian Krone';
      case 'DKK':
        return 'Danish Krone';
      case 'PLN':
        return 'Polish Złoty';
      case 'CZK':
        return 'Czech Koruna';
      case 'HUF':
        return 'Hungarian Forint';
      case 'RUB':
        return 'Russian Ruble';
      case 'BRL':
        return 'Brazilian Real';
      case 'MXN':
        return 'Mexican Peso';
      case 'SGD':
        return 'Singapore Dollar';
      case 'HKD':
        return 'Hong Kong Dollar';
      case 'NZD':
        return 'New Zealand Dollar';
      case 'ZAR':
        return 'South African Rand';
      case 'TRY':
        return 'Turkish Lira';
      case 'ILS':
        return 'Israeli New Shekel';
      case 'AED':
        return 'UAE Dirham';
      case 'SAR':
        return 'Saudi Riyal';
      case 'EGP':
        return 'Egyptian Pound';
      case 'THB':
        return 'Thai Baht';
      case 'VND':
        return 'Vietnamese Dong';
      case 'IDR':
        return 'Indonesian Rupiah';
      case 'MYR':
        return 'Malaysian Ringgit';
      case 'PHP':
        return 'Philippine Peso';
      default:
        return currencyCode.toUpperCase();
    }
  }

  /// Formats percentage values
  static String formatPercentage(double percentage, {int decimalPlaces = 1}) {
    if (percentage.isNaN || percentage.isInfinite) {
      return '0.0%';
    }
    return '${percentage.toStringAsFixed(decimalPlaces)}%';
  }

  /// Formats exchange rate
  static String formatExchangeRate(String fromCurrency, String toCurrency, double rate) {
    if (rate.isNaN || rate.isInfinite || rate <= 0) {
      return '1 ${fromCurrency.toUpperCase()} = N/A ${toCurrency.toUpperCase()}';
    }
    return '1 ${fromCurrency.toUpperCase()} = ${rate.toStringAsFixed(4)} ${toCurrency.toUpperCase()}';
  }

  /// Formats exchange rate in reverse
  static String formatReverseExchangeRate(String fromCurrency, String toCurrency, double rate) {
    if (rate.isNaN || rate.isInfinite || rate <= 0) {
      return '1 ${toCurrency.toUpperCase()} = N/A ${fromCurrency.toUpperCase()}';
    }
    final reverseRate = 1 / rate;
    return '1 ${toCurrency.toUpperCase()} = ${reverseRate.toStringAsFixed(4)} ${fromCurrency.toUpperCase()}';
  }

  /// Parses currency string to double
  static double? parseAmount(String amountString) {
    try {
      if (amountString.isEmpty) return null;

      // Remove currency symbols and formatting
      String cleanAmount = amountString.replaceAll(RegExp(r'[^\d.,-]'), '').replaceAll(RegExp(r'[,\s]'), '');

      // Handle negative values
      final isNegative = amountString.contains('-');
      cleanAmount = cleanAmount.replaceAll('-', '');

      final parsedAmount = double.tryParse(cleanAmount);
      if (parsedAmount == null) return null;

      return isNegative ? -parsedAmount : parsedAmount;
    } catch (e) {
      return null;
    }
  }

  /// Formats amount with color coding for positive/negative values
  static Map<String, dynamic> formatWithColor(double amount, String currencyCode) {
    final formattedAmount = format(amount, currencyCode);
    final isPositive = amount >= 0;
    final isZero = amount == 0;

    return {
      'text': formattedAmount,
      'isPositive': isPositive,
      'isZero': isZero,
      'colorName': isZero ? 'grey' : (isPositive ? 'green' : 'red'),
      'amount': amount,
    };
  }

  /// Formats amount difference (e.g., "+$100.00" or "-$50.00")
  static String formatDifference(double amount, String currencyCode) {
    final formatted = format(amount.abs(), currencyCode);
    if (amount > 0) {
      return '+$formatted';
    } else if (amount < 0) {
      return '-$formatted';
    } else {
      return formatted;
    }
  }

  /// Formats amount range (e.g., "$100.00 - $500.00")
  static String formatRange(double minAmount, double maxAmount, String currencyCode) {
    final minFormatted = format(minAmount, currencyCode);
    final maxFormatted = format(maxAmount, currencyCode);
    return '$minFormatted - $maxFormatted';
  }

  /// Validates currency code
  static bool isValidCurrencyCode(String currencyCode) {
    final validCodes = [
      'USD',
      'EUR',
      'GBP',
      'JPY',
      'PKR',
      'INR',
      'CNY',
      'KRW',
      'AUD',
      'CAD',
      'CHF',
      'SEK',
      'NOK',
      'DKK',
      'PLN',
      'CZK',
      'HUF',
      'RUB',
      'BRL',
      'MXN',
      'SGD',
      'HKD',
      'NZD',
      'ZAR',
      'TRY',
      'ILS',
      'AED',
      'SAR',
      'EGP',
      'THB',
      'VND',
      'IDR',
      'MYR',
      'PHP',
      'TWD',
      'CLP',
      'COP',
      'PEN',
      'UYU',
      'ARS',
      'KZT',
      'UAH',
      'BGN',
      'RON',
      'HRK',
      'ISK',
      'MAD',
      'TND',
      'JOD',
      'KWD',
      'BHD',
      'OMR',
      'QAR',
      'LBP',
      'SYP',
      'IQD',
      'IRR',
      'AFN',
      'BDT',
      'BTN',
      'LKR',
      'MVR',
      'NPR',
      'LAK',
      'KHR',
      'MMK',
      'BND',
      'FJD',
      'PGK',
      'SBD',
      'TOP',
      'VUV',
      'WST',
    ];

    return validCodes.contains(currencyCode.toUpperCase());
  }

  /// Check if currency uses decimal places
  static bool usesDecimals(String currencyCode) {
    return _getDecimalPlaces(currencyCode) > 0;
  }

  /// Convert between currencies (requires exchange rate)
  static double convertCurrency(double amount, double exchangeRate) {
    if (exchangeRate.isNaN || exchangeRate.isInfinite || exchangeRate <= 0) {
      return 0.0;
    }
    return amount * exchangeRate;
  }

  /// Format converted amount with both currencies
  static String formatConversion(double originalAmount, String fromCurrency, double convertedAmount, String toCurrency) {
    final original = format(originalAmount, fromCurrency);
    final converted = format(convertedAmount, toCurrency);
    return '$original ➜ $converted';
  }

  /// Get major currency units (e.g., "dollars" for USD)
  static String getMajorUnit(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
      case 'AUD':
      case 'CAD':
      case 'HKD':
      case 'NZD':
      case 'SGD':
        return 'dollars';
      case 'EUR':
        return 'euros';
      case 'GBP':
        return 'pounds';
      case 'JPY':
      case 'CNY':
        return 'yen';
      case 'PKR':
      case 'INR':
      case 'LKR':
        return 'rupees';
      case 'KRW':
        return 'won';
      case 'CHF':
        return 'francs';
      case 'SEK':
      case 'NOK':
      case 'DKK':
        return 'krona';
      case 'RUB':
        return 'rubles';
      default:
        return currencyCode.toLowerCase();
    }
  }

  /// Get minor currency units (e.g., "cents" for USD)
  static String getMinorUnit(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
      case 'AUD':
      case 'CAD':
      case 'EUR':
      case 'HKD':
      case 'NZD':
      case 'SGD':
        return 'cents';
      case 'GBP':
        return 'pence';
      case 'PKR':
      case 'INR':
      case 'LKR':
        return 'paisa';
      case 'JPY':
      case 'KRW':
        return ''; // No minor units
      case 'CHF':
        return 'rappen';
      case 'SEK':
      case 'NOK':
      case 'DKK':
        return 'öre';
      case 'RUB':
        return 'kopecks';
      default:
        return 'units';
    }
  }

  /// Private method to get or create formatter for currency
  static NumberFormat _getFormatter(String currencyCode) {
    final key = currencyCode.toUpperCase();

    if (!_formatters.containsKey(key)) {
      try {
        _formatters[key] = NumberFormat.currency(symbol: getCurrencySymbol(currencyCode), decimalDigits: _getDecimalPlaces(currencyCode));
      } catch (e) {
        // Fallback formatter
        _formatters[key] = NumberFormat.currency(symbol: getCurrencySymbol(currencyCode), decimalDigits: 2);
      }
    }

    return _formatters[key]!;
  }

  /// Gets appropriate decimal places for currency
  static int _getDecimalPlaces(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'JPY':
      case 'KRW':
      case 'VND':
      case 'IDR':
      case 'CLP':
      case 'PYG':
      case 'RWF':
      case 'UGX':
      case 'XAF':
      case 'XOF':
      case 'XPF':
        return 0; // These currencies typically don't use decimal places
      case 'BHD':
      case 'KWD':
      case 'OMR':
      case 'JOD':
        return 3; // These currencies use 3 decimal places
      case 'CLF':
        return 4; // Chilean Unit of Account uses 4 decimal places
      default:
        return 2; // Most currencies use 2 decimal places
    }
  }

  /// Clear cached formatters (useful for memory management)
  static void clearCache() {
    _formatters.clear();
    _compactFormatters.clear();
  }

  /// Get formatter statistics (for debugging)
  static Map<String, int> getFormatterStats() {
    return {'formatters': _formatters.length, 'compactFormatters': _compactFormatters.length};
  }
}
