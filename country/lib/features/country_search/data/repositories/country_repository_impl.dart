import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';

import '../../../../core/networks/network_info.dart';
import '../../domain/entities/country.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/country_local_data_source.dart';
import '../datasources/country_remote_data_source.dart';
import '../models/country_model.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource remoteDataSource;
  final CountryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CountryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Country>>> getAllCountries() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCountries = await remoteDataSource.getAllCountries();
        return Right(remoteCountries.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure('Server error'));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Country>> getCountryDetail(String countryCode) async {
    if (await networkInfo.isConnected) {
      try {
        final country = await remoteDataSource.getCountryDetail(countryCode);
        return Right(country.toEntity());
      } on ServerException {
        return Left(ServerFailure('Failed to load country details'));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Country>>> searchCountriess(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final results = await remoteDataSource.searchCountries(query);
        return Right(results.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure('Search failed'));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorites(Country country) async {
    try {
      await localDataSource.addFavorite(CountryModel.fromEntity(country));
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure('Could not add favorite'));
    }
  }

  @override
  Future<Either<Failure, List<Country>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      return Right(favorites.map((model) => model.toEntity()).toList());
    } on CacheException {
      return Left(CacheFailure('Could not get favorites'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorites(Country country) async {
    try {
      await localDataSource.removeFavorite(CountryModel.fromEntity(country));
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure('Could not remove favorite'));
    }
  }
}

// Add these extensions for conversion
extension CountryModelX on CountryModel {
  Country toEntity() => Country(
    name: name,
    flag: flag,
    population: population,
    region: region,
    subregion: subregion,
    area: area,
    timezones: timezones,
    countryCode: countryCode,
  );
}

extension CountryX on Country {
  CountryModel fromEntity() => CountryModel(
    name: name,
    flag: flag,
    population: population,
    region: region,
    subregion: subregion,
    area: area,
    timezones: timezones,
    countryCode: countryCode,
  );
}
