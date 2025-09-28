import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/pokedex/pokedex_bloc.dart';
import 'package:flutter_pokedex_2/constants.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokemons_grid.dart';
import 'package:flutter_pokedex_2/widgets/pokemon_loader.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kPadding * 2.2, left: kPadding / 4),
      child: BlocProvider(
        create: (context) => PokedexBloc()..add(PokedexEvent.load()),
        child: BlocBuilder<PokedexBloc, PokedexState>(
          builder: (context, state) {
            switch (state) {
              case Initial():
              case Loading():
                return PokemonLoader();
              case Loaded():
                final hasMore = (state.query == null || state.query!.isEmpty) && state.pokeList.next != null;
                return PokemonsGrid(pokemons: state.pokemons, hasMore: hasMore);
              case Error():
                return Center(child: Text('Something went wrong, try again'));
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
