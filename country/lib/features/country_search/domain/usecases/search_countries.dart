import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class SearchCountriess {
  final CountryRepository repository;

  SearchCountriess(this.repository);

  Future<Either<Failure, List<Country>>> call(String query) async {
    return await repository.searchCountriess(query);
  }
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure(String message) : super(message);
}
