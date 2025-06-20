import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/country.dart';
import '../bloc/favorite_bloc.dart';
import '../pages/country_detail_page.dart';

class CountryListItem extends StatelessWidget {
  final Country country;
  final bool isFavorite;

  const CountryListItem({
    super.key,
    required this.country,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        child:
            country.flag.contains('.svg')
                ? SvgPicture.network(country.flag)
                : Image.network(country.flag),
      ),
      title: Text(country.name),
      subtitle: Text('Population: ${country.population}'),
      trailing:
          isFavorite
              ? IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  context.read<FavoriteBloc>().add(RemoveFavorite(country));
                },
              )
              : BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  final isFav =
                      state is FavoriteLoaded &&
                      state.favorites.any((c) => c.name == country.name);
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (isFav) {
                        context.read<FavoriteBloc>().add(
                          RemoveFavorite(country),
                        );
                      } else {
                        context.read<FavoriteBloc>().add(AddFavorite(country));
                      }
                    },
                  );
                },
              ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CountryDetailPage(country: country),
          ),
        );
      },
    );
  }
}
