import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/poke_favorites/poke_favorites_bloc.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokemon_card.dart';

class FavoritePokemonsGrid extends StatelessWidget {
  const FavoritePokemonsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokeFavoritesBloc, PokeFavoritesState>(
      builder: (context, state) {
        if (state.favorites.isEmpty) {
          return const Center(
            child: Text('No favorites yet', style: TextStyle(color: Colors.white)),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 4),
          itemCount: state.favorites.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return PokemonCard(pokemon: state.favorites[index]);
          },
        );
      },
    );
  }
}
