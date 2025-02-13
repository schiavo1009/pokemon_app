import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon_types.entity.dart';

import 'pokemon_type.model.dart';

class PokemonTypesModel extends PokemonTypesEntity {
  factory PokemonTypesModel(Map<String, dynamic> json) {
    return PokemonTypesModel._(
      type: PokemonTypeModel(json['type']),
    );
  }

  PokemonTypesModel._(
      {
      required super.type,
      });
}

