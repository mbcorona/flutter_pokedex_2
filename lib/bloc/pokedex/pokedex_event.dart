part of 'pokedex_bloc.dart';

@freezed
class PokedexEvent with _$PokedexEvent {
  const factory PokedexEvent.load() = _Load;
  const factory PokedexEvent.loadMore() = _LoadMore;
  const factory PokedexEvent.search(String query) = _Search;
}
