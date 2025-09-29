import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/poke_favorites/poke_favorites_bloc.dart';
import 'package:flutter_pokedex_2/widgets/favorite_button.dart';
import 'package:pokeapi/domain/models/models.dart';

class PokemonFavoriteButton extends StatelessWidget {
  const PokemonFavoriteButton({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokeFavoritesBloc, PokeFavoritesState>(
      builder: (context, state) {
        final isFavorite = state.isFavorite(pokemon);
        return FavoriteButton(
          onTap: () {
            if (isFavorite) {
              context.read<PokeFavoritesBloc>().add(PokeFavoritesEvent.remove(pokemon));
            } else {
              context.read<PokeFavoritesBloc>().add(PokeFavoritesEvent.add(pokemon));
            }
          },
          isFavorite: isFavorite,
        );
      },
    );
  }
}
