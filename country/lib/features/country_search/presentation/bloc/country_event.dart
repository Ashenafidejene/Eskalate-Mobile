part of 'country_bloc.dart';

sealed class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class LoadAllCountries extends CountryEvent {}

class SearchCountries extends CountryEvent {
  final String query;

  const SearchCountries(this.query);

  @override
  List<Object> get props => [query];
}

class LoadCountryDetail extends CountryEvent {
  final String countryCode;

  const LoadCountryDetail(this.countryCode);

  @override
  List<Object> get props => [countryCode];
}
