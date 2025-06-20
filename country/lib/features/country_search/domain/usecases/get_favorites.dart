import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class GetFavorites {
  final CountryRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<Country>>> call() async {
    return await repository.getFavorites();
  }
}
