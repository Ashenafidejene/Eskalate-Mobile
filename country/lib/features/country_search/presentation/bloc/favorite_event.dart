part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  final Country country;

  const AddFavorite(this.country);

  @override
  List<Object> get props => [country];
}

class RemoveFavorite extends FavoriteEvent {
  final Country country;

  const RemoveFavorite(this.country);

  @override
  List<Object> get props => [country];
}
