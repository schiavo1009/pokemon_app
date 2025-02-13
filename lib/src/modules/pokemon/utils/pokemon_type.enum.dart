import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/constants/colors_system.dart';
import 'package:pokemon_app/src/modules/pokemon/utils/pokemon_constants.dart';

enum PokemonTypeEnum {
  grass(name: PokemonConstants.grass, color: ColorsSystem.grassType),
  psychic(name: PokemonConstants.psychic, color: ColorsSystem.psychicType),
  poison(name: PokemonConstants.poison, color: ColorsSystem.poisonType),
  fire(name: PokemonConstants.fire, color: ColorsSystem.fireType),
  water(name: PokemonConstants.water, color: ColorsSystem.waterType),
  bug(name: PokemonConstants.bug, color: ColorsSystem.bugType),
  normal(name: PokemonConstants.normal, color: ColorsSystem.normalType),
  ground(name: PokemonConstants.ground, color: ColorsSystem.groundType),
  fighting(name: PokemonConstants.fighting, color: ColorsSystem.fightingType),
  rock(name: PokemonConstants.rock, color: ColorsSystem.rockType),

  electric(name: PokemonConstants.electric, color: ColorsSystem.electric),
  unknown(name: PokemonConstants.unknown, color: ColorsSystem.defaultType);

  final String name;
  final Color color;
  const PokemonTypeEnum({required this.name, required this.color});

  static PokemonTypeEnum stringToEnum(String? value) {
    if (value == null) {
      return PokemonTypeEnum.unknown;
    }
    return PokemonTypeEnum.values.firstWhere(
        (d) => d.name.toUpperCase() == value.toUpperCase(),
        orElse: () => PokemonTypeEnum.unknown);
  }
}
