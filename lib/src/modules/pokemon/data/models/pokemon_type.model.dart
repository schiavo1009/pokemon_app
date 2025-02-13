import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon_type.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/utils/pokemon_type.enum.dart';

class PokemonTypeModel extends PokemonTypeEntity {
  factory PokemonTypeModel(Map<String, dynamic> json) {
    return PokemonTypeModel._(
      name: json['name'],
      pokemonTypeEnum: PokemonTypeEnum.stringToEnum(json['name']),
    );
  }

  PokemonTypeModel._({required super.name, required super.pokemonTypeEnum});
}
