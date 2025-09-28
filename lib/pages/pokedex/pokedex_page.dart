import 'package:flutter/material.dart';
import 'package:flutter_pokedex_2/constants.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokedex_background.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokemon_list_view.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  bool detailsMode = false;

  void toggleDetailsMode() {
    setState(() {
      detailsMode = !detailsMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
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
                duration: kTabScrollDuration,
                child: PokemonListView(),
              ),
            ),

            // IgnorePointer(
            //   ignoring: detailsMode ? false : true,
            //   child: AnimatedOpacity(
            //     opacity: detailsMode ? 1 : 0,
            //     duration: fastDefaultDuration,
            //     child: PokemonDetailsView(onClose: toggleDetailsMode),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
