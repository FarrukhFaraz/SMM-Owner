

class WalletConfiguration {
  // API Configuration
  static const String baseUrl = 'https://your-api-domain.com/api';
  static const String version = 'v1';

  // API Endpoints
  static const String userTransactionsEndpoint = '/user_transactions';
  static const String transactionDetailsEndpoint = '/transaction';
  static const String userProfileEndpoint = '/user/profile';
  static const String supportEndpoint = '/support';

  // Network Configuration
  static const int connectTimeoutSeconds = 30;
  static const int receiveTimeoutSeconds = 30;
  static const int sendTimeoutSeconds = 30;
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  // Pagination Configuration
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int preloadThreshold = 5; // Load more when 5 items from end

  // Cache Configuration
  static const Duration cacheExpiration = Duration(minutes: 30);
  static const int maxCacheSize = 50; // Maximum number of cached responses

  // Environment Configuration
  static bool get isProduction => const String.fromEnvironment('ENVIRONMENT') == 'production';
  static bool get isDevelopment => const String.fromEnvironment('ENVIRONMENT') == 'development';
  static bool get isStaging => const String.fromEnvironment('ENVIRONMENT') == 'staging';
  static bool get isDebug => !isProduction;

  // Feature Flags
  static const bool enableAdvancedFiltering = true;
  static const bool enableTransactionSharing = true;
  static const bool enableReceiptDownload = false;
  static const bool enableLiveChat = false;
  static const bool enableBiometricAuth = true;
  static const bool enablePushNotifications = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;

  // Supported Features by Environment
  static bool get enableDebugMode => isDevelopment || isStaging;
  static bool get enablePerformanceMonitoring => isProduction;
  static bool get enableDetailedLogging => !isProduction;

  // Currency Configuration
  static const List<String> supportedCurrencies = [
    'USD', 'EUR', 'GBP', 'JPY', 'PKR', 'INR', 'CNY', 'KRW',
    'AUD', 'CAD', 'CHF', 'SEK', 'NOK', 'DKK', 'PLN', 'CZK',
    'HUF', 'RUB', 'BRL', 'MXN', 'SGD', 'HKD', 'NZD', 'ZAR',
    'TRY', 'ILS', 'AED', 'SAR', 'EGP', 'THB', 'VND', 'IDR',
    'MYR', 'PHP'
  ];

  static const String defaultCurrency = 'USD';
  static const int currencyDecimalPlaces = 2;
  static const bool showCurrencySymbol = true;

  // Transaction Configuration
  static const List<String> supportedTransactionTypes = [
    'deposit',
    'withdraw',
    'transfer',
    'payment',
    'refund',
    'bonus',
    'fee',
    'adjustment'
  ];

  static const List<String> supportedTransactionStatuses = [
    'pending',
    'processing',
    'completed',
    'failed',
    'cancelled',
    'rejected',
    'refunded'
  ];

  // UI Configuration
  static const int shimmerItemCount = 10;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  static const double defaultBorderRadius = 12.0;
  static const double cardElevation = 2.0;

  // Error Handling Configuration
  static const int maxErrorRetries = 3;
  static const Duration errorSnackbarDuration = Duration(seconds: 4);
  static const Duration successSnackbarDuration = Duration(seconds: 2);

  // Security Configuration
  static const Duration sessionTimeout = Duration(hours: 4);
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 30);
  static const bool requireBiometricForLargeAmounts = true;
  static const double biometricThreshold = 1000.0; // Amount threshold for biometric

  // Notification Configuration
  static const bool enableTransactionNotifications = true;
  static const bool enableSecurityNotifications = true;
  static const bool enableMarketingNotifications = false;

  // Date/Time Configuration
  static const String defaultDateFormat = 'MMM dd, yyyy';
  static const String defaultDateTimeFormat = 'MMM dd, yyyy • hh:mm a';
  static const String apiDateFormat = 'yyyy-MM-dd';
  static const String apiDateTimeFormat = 'yyyy-MM-ddTHH:mm:ss';

  // Validation Configuration
  static const int minTransactionAmount = 1;
  static const int maxTransactionAmount = 1000000;
  static const int maxMemoLength = 255;
  static const int maxSearchQueryLength = 100;

  // Performance Configuration
  static const int listViewCacheExtent = 1000;
  static const bool enableImageCaching = true;
  static const Duration imageCacheExpiration = Duration(days: 7);

  // Analytics Configuration
  static const bool trackScreenViews = true;
  static const bool trackUserActions = true;
  static const bool trackErrors = true;
  static const bool trackPerformance = true;

  // Development/Debug Configuration
  static const bool enableFlutterInspector = true;
  static const bool enablePerformanceOverlay = false;
  static const bool enableDebugPaint = false;

  // Support Configuration
  static const String supportEmail = 'support@yourcompany.com';
  static const String supportPhone = '+1-555-123-4567';
  static const String helpCenterUrl = 'https://help.yourcompany.com';
  static const String privacyPolicyUrl = 'https://yourcompany.com/privacy';
  static const String termsOfServiceUrl = 'https://yourcompany.com/terms';

  // Social Media Links
  static const String facebookUrl = 'https://facebook.com/yourcompany';
  static const String twitterUrl = 'https://twitter.com/yourcompany';
  static const String linkedinUrl = 'https://linkedin.com/company/yourcompany';

  // App Store Links
  static const String appStoreUrl = 'https://apps.apple.com/app/yourapp';
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.yourcompany.yourapp';

  // API Rate Limiting
  static const int apiRateLimit = 100; // requests per minute
  static const Duration rateLimitWindow = Duration(minutes: 1);

  // File Upload Configuration
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedFileTypes = ['jpg', 'jpeg', 'png', 'pdf'];

  // Localization Configuration
  static const List<String> supportedLocales = ['en', 'es', 'fr', 'de', 'ar', 'ur'];
  static const String defaultLocale = 'en';

  // Theme Configuration
  static const bool enableDarkMode = true;
  static const bool followSystemTheme = true;

  // Method to get full API URL
  static String getApiUrl(String endpoint) {
    if (endpoint.startsWith('/')) {
      return '$baseUrl$endpoint';
    }
    return '$baseUrl/$endpoint';
  }

  // Method to get environment-specific configuration
  static Map<String, dynamic> getEnvironmentConfig() {
    return {
      'baseUrl': baseUrl,
      'isProduction': isProduction,
      'isDevelopment': isDevelopment,
      'isStaging': isStaging,
      'enableDebugMode': enableDebugMode,
      'enableDetailedLogging': enableDetailedLogging,
      'maxRetryAttempts': maxRetryAttempts,
      'pageSize': defaultPageSize,
    };
  }

  // Method to validate currency
  static bool isSupportedCurrency(String currency) {
    return supportedCurrencies.contains(currency.toUpperCase());
  }

  // Method to validate transaction type
  static bool isSupportedTransactionType(String type) {
    return supportedTransactionTypes.contains(type.toLowerCase());
  }

  // Method to validate transaction status
  static bool isSupportedTransactionStatus(String status) {
    return supportedTransactionStatuses.contains(status.toLowerCase());
  }

  // Method to get timeout configuration
  static Duration getTimeout(String operation) {
    switch (operation.toLowerCase()) {
      case 'connect':
        return Duration(seconds: connectTimeoutSeconds);
      case 'receive':
        return Duration(seconds: receiveTimeoutSeconds);
      case 'send':
        return Duration(seconds: sendTimeoutSeconds);
      default:
        return Duration(seconds: connectTimeoutSeconds);
    }
  }

  // Method to check if feature is enabled
  static bool isFeatureEnabled(String feature) {
    switch (feature.toLowerCase()) {
      case 'advanced_filtering':
        return enableAdvancedFiltering;
      case 'transaction_sharing':
        return enableTransactionSharing;
      case 'receipt_download':
        return enableReceiptDownload;
      case 'live_chat':
        return enableLiveChat;
      case 'biometric_auth':
        return enableBiometricAuth;
      case 'push_notifications':
        return enablePushNotifications;
      case 'analytics':
        return enableAnalytics;
      case 'crash_reporting':
        return enableCrashReporting;
      default:
        return false;
    }
  }

  // Method to get API headers
  static Map<String, String> getDefaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'WalletApp/${version}',
      'X-API-Version': version,
    };
  }

  // Method to get authenticated headers
  static Map<String, String> getAuthenticatedHeaders(String token) {
    final headers = getDefaultHeaders();
    headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  // Method for development/debug settings
  static Map<String, dynamic> getDebugSettings() {
    if (!enableDebugMode) return {};

    return {
      'enableFlutterInspector': enableFlutterInspector,
      'enablePerformanceOverlay': enablePerformanceOverlay,
      'enableDebugPaint': enableDebugPaint,
      'enableDetailedLogging': enableDetailedLogging,
    };
  }
}