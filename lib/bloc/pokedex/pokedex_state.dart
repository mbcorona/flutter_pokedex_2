part of 'pokedex_bloc.dart';

@freezed
class PokedexState with _$PokedexState {
  const factory PokedexState.initial() = Initial;
  const factory PokedexState.loading() = Loading;
  const factory PokedexState.loaded({required PokeList<Pokemon> pokeList, String? query}) = Loaded;
  const factory PokedexState.error() = Error;
}

extension PokedexStateX on Loaded {
  List<Pokemon> get pokemons {
    if (query == null || query!.isEmpty) {
      return pokeList.results;
    }
    return pokeList.results.where((element) => element.name.toLowerCase().contains(query!.toLowerCase())).toList();
  }
}
