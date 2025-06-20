import 'package:flutter/material.dart';
import '../../domain/entities/country.dart';
import 'country_card.dart';

class CountryGrid extends StatelessWidget {
  final List<Country> countries;

  const CountryGrid({super.key, required this.countries});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3.5, // ⬅️ make this slightly taller
        crossAxisSpacing: 8,
        mainAxisSpacing: 4, // ⬅️ reduce vertical spacing
      ),
      itemCount: countries.length,
      itemBuilder: (context, index) => CountryCard(country: countries[index]),
    );
  }
}
