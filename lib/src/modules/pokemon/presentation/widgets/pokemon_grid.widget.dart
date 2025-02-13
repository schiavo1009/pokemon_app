import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/config/shared_config.dart';
import 'package:pokemon_app/src/core/constants/layout_space.enum.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/widgets/pokemon_item.widget.dart';

class PokemonGridWidget extends StatelessWidget {
  final List<PokemonEntity> pokemons;
  final Function(int index) onPressFavoritePokemon;
  final Function(int index) onPressCard;
  final ScrollController? scrollController;
  const PokemonGridWidget({
    super.key,
    required this.pokemons,
    required this.onPressFavoritePokemon,
    required this.onPressCard,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        controller: scrollController,
        mainAxisSpacing: LayoutSpace.m.size,
        crossAxisSpacing: LayoutSpace.s.size,
        crossAxisCount: 2,
        padding: EdgeInsets.all(LayoutSpace.m.size),
        children: pokemons.map((pokemon) 
          =>  PokemonItem(
            index: pokemon.id,
            name: pokemon.name,
            isFavorite: pokemon.isFavorite,
            onPressCard: (index) {
              onPressCard(index);
            },
            onPressFavorite: (index) {
              onPressFavoritePokemon(index);
            },
            urlImage:
                SharedConfigs.instance.endpoints.getImagePath((pokemon.id)),
          )
        ).toList());
  }
}
