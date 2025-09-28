import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/selected_pokemon/selected_pokemon_cubit.dart';
import 'package:flutter_pokedex_2/constants.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokemon_details/pokemon_details_view.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokedex_background.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokemon_list_view.dart';
import 'package:pokeapi/domain/models/models.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => SelectedPokemonCubit(),
      child: Scaffold(
        backgroundColor: kRedColor,
        body: BlocBuilder<SelectedPokemonCubit, Pokemon?>(
          builder: (context, pokemon) {
            final detailsMode = pokemon != null;
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  // Red/White POkedex Background
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeInOutBack,
                    top: 0,
                    left: detailsMode ? (size.width - kPadding * 2) * -1 : 0,
                    right: 0,
                    bottom: 0,
                    child: const PokedexBackground(),
                  ),
                  IgnorePointer(
                    ignoring: detailsMode ? true : false,
                    child: AnimatedOpacity(
                      opacity: detailsMode ? 0 : 1,
                      duration: kAnimationDuration,
                      child: PokemonListView(),
                    ),
                  ),

                  IgnorePointer(
                    ignoring: detailsMode ? false : true,
                    child: AnimatedOpacity(
                      opacity: detailsMode ? 1 : 0,
                      duration: kAnimationDuration,
                      child: PokemonDetailsView(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
