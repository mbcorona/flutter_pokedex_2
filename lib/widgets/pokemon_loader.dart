import 'package:flutter/material.dart';

class PokemonLoader extends StatelessWidget {
  const PokemonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Loading...",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
      ),
    );
  }
}
