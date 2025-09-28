import 'package:flutter/material.dart';
import 'package:flutter_pokedex_2/constants.dart';

class PokedexBackground extends StatelessWidget {
  const PokedexBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    print('AYEEE');
    return Stack(
      children: [
        // Red / White Backgrond
        Positioned(
          top: 0,
          left: -size.width,
          child: Row(
            children: [
              Container(width: (size.width * 2) - kPadding, height: size.height, color: kRedColor),
              Container(width: (size.width * 2) - kPadding, height: size.height, color: Colors.white),
            ],
          ),
        ),
        // Black line
        Positioned(
          top: 0,
          bottom: 0,
          left: size.width - kPadding * 1.3,
          child: Container(width: kPadding / 2, height: size.height, color: Colors.black),
        ),
        // Pokeball Circles
        Positioned(
          top: size.height / 2 - kPadding,
          left: size.width - kPadding * 2,
          child: const CircleAvatar(
            radius: kPadding - 1,
            backgroundColor: Colors.black,
            child: CircleAvatar(radius: kPadding - kPadding * .5, backgroundColor: Colors.white),
          ),
        ),
      ],
    );
  }
}
