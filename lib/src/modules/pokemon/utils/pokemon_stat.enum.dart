import 'package:pokemon_app/src/modules/pokemon/utils/pokemon_constants.dart';

enum PokemonStatEnum {
  attack(name: PokemonConstants.attack),
  defense(name: PokemonConstants.defense),
  specialAttack(name: PokemonConstants.specialAttack),
  specialDefense(name: PokemonConstants.specialDefense),
  speed(name: PokemonConstants.speed),
  hp(name: PokemonConstants.hp),
  unknown(name: PokemonConstants.unknown);

  final String name;
  const PokemonStatEnum({required this.name});

  static PokemonStatEnum stringToEnum(String? value) {
    if (value == null) {
      return PokemonStatEnum.unknown;
    }
    return PokemonStatEnum.values.firstWhere(
        (d) => d.name.toUpperCase() == value.toUpperCase(),
        orElse: () => PokemonStatEnum.unknown);
  }
}
