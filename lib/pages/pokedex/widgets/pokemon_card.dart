import 'package:flutter/material.dart';
import 'package:pokeapi/domain/models/models.dart' hide PokemonDetails;

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(pokemon.image),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(pokemon.id.padLeft(4, '0'), style: TextStyle(color: Colors.grey)),
            ),
            Text(pokemon.name.toUpperCase()),
            // PokemonDetails(id: pokemon.id),
          ],
        ),
      ),
    );
  }
}
