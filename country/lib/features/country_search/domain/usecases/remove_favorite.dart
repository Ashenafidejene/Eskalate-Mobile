import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class RemoveFavorites {
  final CountryRepository repository;

  RemoveFavorites(this.repository);

  Future<Either<Failure, void>> call(Country country) async {
    return await repository.removeFavorites(country);
  }
}
