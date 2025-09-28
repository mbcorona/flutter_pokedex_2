import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokeapi/data/api/pokeapi_impl.dart';
import 'package:pokeapi/domain/api/pokeapi.dart';
import 'package:pokeapi/domain/models/pokemon/pokemon.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';
part 'pokemon_bloc.freezed.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc({PokeApi? api}) : _api = api ?? PokeApiImpl(), super(Initial()) {
    on<_Load>(_onLoad);
  }

  PokeApi _api;
  Future<void> _onLoad(_Load event, Emitter<PokemonState> emit) async {
    emit(const PokemonState.loading());
    try {
      final pokemon = await _api.getDetails(event.id);
      emit(PokemonState.loaded(pokemon: pokemon));
    } catch (e) {
      emit(const PokemonState.error());
    }
  }
}
