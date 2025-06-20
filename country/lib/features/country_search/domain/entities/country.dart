import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String flag;
  final int population;
  final String region;
  final String? subregion;
  final double? area;
  final List<String>? timezones;
  final String? countryCode;

  const Country({
    required this.name,
    required this.flag,
    required this.population,
    required this.region,
    this.subregion,
    this.area,
    this.timezones,
    this.countryCode,
  });

  // Add these conversion methods
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

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json['name']['common'] ?? 'Unknown',
    flag: json['flags']?['png'] ?? '',
    population: json['population'] ?? 0,
    region: json['region'] ?? 'Unknown',
    subregion: json['subregion'],
    area: json['area']?.toDouble(),
    timezones: json['timezones']?.cast<String>(),
    countryCode: json['cca2'],
  );

  @override
  List<Object?> get props => [
    name,
    flag,
    population,
    region,
    subregion,
    area,
    timezones,
    countryCode,
  ];
}
