import '../../../../core/errors/failures.dart';
import '../entities/country.dart';
import 'package:dartz/dartz.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<Country>>> getAllCountries();

  Future<Either<Failure, Country>> getCountryDetail(String countryCode);

  Future<Either<Failure, List<Country>>> searchCountriess(String query);

  Future<Either<Failure, void>> addFavorites(Country country);

  Future<Either<Failure, void>> removeFavorites(Country country);

  Future<Either<Failure, List<Country>>> getFavorites();
}
