import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/country.dart';
import '../bloc/favorite_bloc.dart';
import '../pages/country_detail_page.dart';

class CountryCard extends StatelessWidget {
  final Country country;

  const CountryCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CountryDetailPage(country: country),
            ),
          );
        },
        child: Column(
          children: [
            Expanded(
              child:
                  country.flag.contains('.svg')
                      ? SvgPicture.network(country.flag, fit: BoxFit.cover)
                      : Image.network(country.flag, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      country.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      final isFavorite =
                          state is FavoriteLoaded &&
                          state.favorites.any((c) => c.name == country.name);

                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            context.read<FavoriteBloc>().add(
                              RemoveFavorite(country),
                            );
                          } else {
                            context.read<FavoriteBloc>().add(
                              AddFavorite(country),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Text('Population: ${country.population}'),
            ),
          ],
        ),
      ),
    );
  }
}
