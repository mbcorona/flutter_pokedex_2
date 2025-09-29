part of 'pokemons_bloc.dart';

@freezed
class PokemonsState with _$PokemonsState {
  const factory PokemonsState.initial() = Initial;
  const factory PokemonsState.loading() = Loading;
  const factory PokemonsState.loaded({required PokeList<Pokemon> pokeList, String? query}) = Loaded;
  const factory PokemonsState.error() = Error;
}

extension PokemonsStateX on Loaded {
  List<Pokemon> get pokemons {
    if (query == null || query!.isEmpty) {
      return pokeList.results;
    }
    return pokeList.results.where((element) => element.name.toLowerCase().contains(query!.toLowerCase())).toList();
  }
}
