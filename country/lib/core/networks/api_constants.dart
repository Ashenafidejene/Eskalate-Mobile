class ApiConstants {
  static const String baseUrl = 'https://restcountries.com/v3.1';

  // Endpoints
  static const String allCountries = '/all';
  static const String countryByName = '/name';
  static const String countryByCode = '/alpha';

  // Query parameters
  static const String fields = 'fields';

  // Commonly used field combinations
  static const String basicFields = 'name,flags,population,region';
  static const String detailFields =
      'name,flags,population,area,region,subregion,timezones';

  // Timeouts
  static const int connectTimeout = 5000; // 5 seconds
  static const int receiveTimeout = 10000; // 10 seconds
}
