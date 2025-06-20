import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/country_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search countries...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onChanged: (query) {
        if (query.length > 2) {
          context.read<CountryBloc>().add(SearchCountries(query));
        } else if (query.isEmpty) {
          context.read<CountryBloc>().add(LoadAllCountries());
        }
      },
    );
  }
}
