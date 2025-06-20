import '../../domain/entities/country.dart';

class CountryModel {
  final String name;
  final String flag;
  final int population;
  final String region;
  final String? subregion;
  final double? area;
  final List<String>? timezones;
  final String? countryCode;

  CountryModel({
    required this.name,
    required this.flag,
    required this.population,
    required this.region,
    this.subregion,
    this.area,
    this.timezones,
    this.countryCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    name: json['name']['common'] ?? 'Unknown',
    flag: json['flags']?['png'] ?? '',
    population: json['population'] ?? 0,
    region: json['region'] ?? 'Unknown',
    subregion: json['subregion'],
    area: json['area']?.toDouble(),
    timezones: json['timezones']?.cast<String>(),
    countryCode: json['cca2'],
  );

  Map<String, dynamic> toJson() => {
    'name': {'common': name},
    'flags': {'png': flag},
    'population': population,
    'region': region,
    'subregion': subregion,
    'area': area,
    'timezones': timezones,
    'cca2': countryCode,
  };

  // Add this factory method
  factory CountryModel.fromEntity(Country country) => CountryModel(
    name: country.name,
    flag: country.flag,
    population: country.population,
    region: country.region,
    subregion: country.subregion,
    area: country.area,
    timezones: country.timezones,
    countryCode: country.countryCode,
  );
}
