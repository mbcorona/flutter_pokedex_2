part of 'pokemons_bloc.dart';

@freezed
class PokemonsEvent with _$PokemonsEvent {
  const factory PokemonsEvent.load() = _Load;
  const factory PokemonsEvent.loadMore() = _LoadMore;
  const factory PokemonsEvent.search(String query) = _Search;
}
