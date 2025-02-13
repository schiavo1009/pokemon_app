import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon_stat.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/utils/pokemon_stat.enum.dart';

class PokemonStatModel extends PokemonStatEntity {
  factory PokemonStatModel(Map<String, dynamic> json) {
    return PokemonStatModel._(
      name: json['name'],
      statEnum: PokemonStatEnum.stringToEnum(json['name']),
    );
  }
  PokemonStatModel._({
    required super.name,
    super.statEnum,
  });
}
