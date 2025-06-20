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
    return Column(
      children: [
        // Card with image and overlays
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CountryDetailPage(country: country),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Flag image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 160,
                    width: double.infinity,
                    child:
                        country.flag.contains('.svg')
                            ? SvgPicture.network(
                              country.flag,
                              fit: BoxFit.cover,
                            )
                            : Image.network(country.flag, fit: BoxFit.cover),
                  ),
                ),

                // Bottom overlay (population + heart)
                Positioned(
                  bottom: 8,
                  left: 12,
                  right: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Population
                      Row(
                        children: [
                          const Icon(
                            Icons.people_alt_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${country.population}M',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      // Favorite Icon
                      BlocBuilder<FavoriteBloc, FavoriteState>(
                        builder: (context, state) {
                          final isFavorite =
                              state is FavoriteLoaded &&
                              state.favorites.any(
                                (c) => c.name == country.name,
                              );
                          return GestureDetector(
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
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.white,
                              size: 20,
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
        ),

        const SizedBox(height: 8),

        // Country Name below the card
        Text(
          country.name,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
