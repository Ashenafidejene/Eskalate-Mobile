import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class GetCountryDetail {
  final CountryRepository repository;

  GetCountryDetail(this.repository);

  Future<Either<Failure, Country>> call(String countryCode) async {
    return await repository.getCountryDetail(countryCode);
  }
}
