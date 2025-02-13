import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon_stat.model.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon_stats.entity.dart';

class PokemonStatsModel extends PokemonStatsEntity {
  factory PokemonStatsModel(Map<String, dynamic> json) {
    return PokemonStatsModel._(
      baseStat: json['base_stat'],
      stat: PokemonStatModel(json['stat']),
    );
  }

  PokemonStatsModel._(
      {
      required super.baseStat,
      required super.stat,
      });
}

