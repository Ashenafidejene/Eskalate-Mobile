import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class AddFavorites {
  final CountryRepository repository;

  AddFavorites(this.repository);

  Future<Either<Failure, void>> call(Country country) async {
    return await repository.addFavorites(country);
  }
}
