import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokeapi/pokeapi.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

part 'pokedex_bloc.freezed.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  PokedexBloc({PokeApi? api}) : _api = api ?? PokeApiImpl(), super(Initial()) {
    on<_Load>(_onLoad);
    on<_LoadMore>(_onLoadMore);
    on<_Search>(_onSearch);
  }

  final PokeApi _api;
  final int pageSize = 100;
  int page = 0;
  Future<void> _onLoad(_Load event, Emitter<PokedexState> emit) async {
    emit(const PokedexState.loading());
    try {
      final pokelist = await _api.getAll(page: page);
      emit(PokedexState.loaded(pokeList: pokelist));
    } catch (e) {
      emit(const PokedexState.error());
    }
  }

  Future<void> _onLoadMore(_LoadMore event, Emitter<PokedexState> emit) async {
    if (state is Loaded) {
      final pokeList = (state as Loaded).pokeList;
      final hasMore = pokeList.next != null;
      if (hasMore) {
        page++;
        final newPokeLlist = await _api.getAll(page: page);

        emit(
          (state as Loaded).copyWith(
            pokeList: newPokeLlist.copyWith(results: [...pokeList.results, ...newPokeLlist.results]),
          ),
        );
      }
    }
  }

  void _onSearch(_Search event, Emitter<PokedexState> emit) {
    if (state is Loaded) {
      emit((state as Loaded).copyWith(query: event.query));
    }
  }
}
