import 'package:country/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/country.dart';
import '../repositories/country_repository.dart';

class GetAllCountries {
  final CountryRepository repository;

  GetAllCountries(this.repository);

  Future<Either<Failure, List<Country>>> call() async {
    return await repository.getAllCountries();
  }
}
