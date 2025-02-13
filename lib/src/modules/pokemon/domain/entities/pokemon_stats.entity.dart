import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon_stat.entity.dart';

class PokemonStatsEntity {
  int baseStat;
  PokemonStatEntity stat;
  PokemonStatsEntity({required this.baseStat, required this.stat,});
}
