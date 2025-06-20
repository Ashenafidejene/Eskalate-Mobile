part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<Country> favorites;

  const FavoriteLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

final class FavoriteOperationSuccess extends FavoriteState {
  final List<Country> favorites;
  final String message;

  const FavoriteOperationSuccess({required this.favorites, this.message = ''});

  @override
  List<Object> get props => [favorites, message];
}

final class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
