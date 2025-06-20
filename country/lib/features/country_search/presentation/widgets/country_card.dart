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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CountryDetailPage(country: country),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image (fills the card)
            Positioned.fill(
              child:
                  country.flag.contains('.svg')
                      ? SvgPicture.network(country.flag, fit: BoxFit.cover)
                      : Image.network(country.flag, fit: BoxFit.cover),
            ),

            // Dark gradient overlay for better readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  ),
                ),
              ),
            ),

            // Overlay content (name, population, favorite)
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Population + Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.people_alt_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${country.population}M',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        country.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  // Favorite Icon
                  BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      final isFavorite =
                          state is FavoriteLoaded &&
                          state.favorites.any((c) => c.name == country.name);
                      return InkWell(
                        onTap: () {
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
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
