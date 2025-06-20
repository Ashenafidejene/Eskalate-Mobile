import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions.dart';

import '../../../../core/networks/api_client.dart';
import '../../../../core/networks/api_constants.dart';
import '../models/country_model.dart';

abstract class CountryRemoteDataSource {
  Future<List<CountryModel>> getAllCountries();
  Future<CountryModel> getCountryDetail(String countryCode);
  Future<List<CountryModel>> searchCountries(String query);
}

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final ApiClient apiClient;

  CountryRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<CountryModel>> getAllCountries() async {
    try {
      final response = await apiClient.get(
        ApiConstants.allCountries,
        queryParams: {ApiConstants.fields: ApiConstants.basicFields},
      );
      return (response as List)
          .map((json) => CountryModel.fromJson(json))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<CountryModel> getCountryDetail(String countryCode) async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.countryByCode}/$countryCode',
        queryParams: {ApiConstants.fields: ApiConstants.detailFields},
      );
      return CountryModel.fromJson((response as List).first);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<List<CountryModel>> searchCountries(String query) async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.countryByName}/$query',
        queryParams: {ApiConstants.fields: ApiConstants.basicFields},
      );
      return (response as List)
          .map((json) => CountryModel.fromJson(json))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
