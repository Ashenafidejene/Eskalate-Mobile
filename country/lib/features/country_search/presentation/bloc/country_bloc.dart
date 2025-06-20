import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/country.dart';
import '../../domain/usecases/get_all_countries.dart';
import '../../domain/usecases/get_country_detail.dart';
import '../../domain/usecases/search_countries.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final GetAllCountries getAllCountries;
  final GetCountryDetail getCountryDetail;
  final SearchCountriess searchCountries;

  CountryBloc({
    required this.getAllCountries,
    required this.getCountryDetail,
    required this.searchCountries,
  }) : super(CountryInitial()) {
    on<LoadAllCountries>(_onLoadAllCountries);
    on<SearchCountries>(_onSearchCountries);
    on<LoadCountryDetail>(_onLoadCountryDetail);
  }

  Future<void> _onLoadAllCountries(
    LoadAllCountries event,
    Emitter<CountryState> emit,
  ) async {
    emit(CountryLoading());
    final result = await getAllCountries();
    result.fold(
      (failure) => emit(CountryError(failure.message)),
      (countries) => emit(CountryLoaded(countries)),
    );
  }

  Future<void> _onSearchCountries(
    SearchCountries event,
    Emitter<CountryState> emit,
  ) async {
    emit(CountryLoading());
    final result = await searchCountries.call(event.query); // Add .call()
    result.fold(
      (failure) => emit(CountryError(failure.message)),
      (countries) => emit(CountryLoaded(countries)),
    );
  }

  Future<void> _onLoadCountryDetail(
    LoadCountryDetail event,
    Emitter<CountryState> emit,
  ) async {
    emit(CountryLoading());
    final result = await getCountryDetail(event.countryCode);
    result.fold(
      (failure) => emit(CountryError(failure.message)),
      (country) => emit(CountryDetailLoaded(country)),
    );
  }
}
