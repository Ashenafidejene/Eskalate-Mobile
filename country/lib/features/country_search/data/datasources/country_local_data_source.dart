import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/country_model.dart';

abstract class CountryLocalDataSource {
  Future<void> cacheCountries(List<CountryModel> countries);
  Future<List<CountryModel>> getCachedCountries();
  Future<void> addFavorite(CountryModel country);
  Future<void> removeFavorite(CountryModel country);
  Future<List<CountryModel>> getFavorites();
}

class CountryLocalDataSourceImpl implements CountryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CountryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> addFavorite(CountryModel country) async {
    try {
      final favorites = await getFavorites();
      favorites.add(country);
      await _saveFavorites(favorites);
    } on Exception {
      throw CacheException('Could not add favorite');
    }
  }

  @override
  Future<void> removeFavorite(CountryModel country) async {
    try {
      final favorites = await getFavorites();
      favorites.removeWhere((c) => c.countryCode == country.countryCode);
      await _saveFavorites(favorites);
    } on Exception {
      throw CacheException('Could not remove favorite');
    }
  }

  @override
  Future<List<CountryModel>> getFavorites() async {
    try {
      final jsonString = sharedPreferences.getString(AppConstants.favoritesKey);
      if (jsonString == null) return [];

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => CountryModel.fromJson(json)).toList();
    } on Exception {
      throw CacheException('Could not get favorites');
    }
  }

  Future<void> _saveFavorites(List<CountryModel> favorites) async {
    final jsonList = favorites.map((country) => country.toJson()).toList();
    await sharedPreferences.setString(
      AppConstants.favoritesKey,
      jsonEncode(jsonList),
    );
  }

  @override
  Future<void> cacheCountries(List<CountryModel> countries) {
    // Implement if you want to cache all countries
    throw UnimplementedError();
  }

  @override
  Future<List<CountryModel>> getCachedCountries() {
    // Implement if you want to cache all countries
    throw UnimplementedError();
  }
}
