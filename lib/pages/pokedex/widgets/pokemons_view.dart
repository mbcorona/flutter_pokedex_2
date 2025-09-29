import 'package:flutter/material.dart';
import 'package:flutter_pokedex_2/constants.dart';
import 'package:flutter_pokedex_2/pages/pokedex/all_pokemons_grid.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/favorite_pokemons_grid.dart';

class PokemonsView extends StatelessWidget {
  const PokemonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kPadding * 2.2, left: kPadding / 4),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      dividerHeight: 0,
                      tabs: [
                        Tab(text: 'All'),
                        Tab(text: 'Favorites'),
                      ],
                    ),
                    SizedBox(height: kPadding / 4),
                    Expanded(child: TabBarView(children: [AllPokemonsGrid(), FavoritePokemonsGrid()])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
