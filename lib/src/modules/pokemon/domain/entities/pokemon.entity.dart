import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon_stats.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon_types.entity.dart';

class PokemonEntity {
  final int id;
  final String name;
  final int? weight;
  final int? height;
  final List<PokemonStatsEntity>? stats;
  final List<PokemonTypesEntity>? types;
  bool? isFavorite;

  void changeIsFavorite(bool isFavorite) {
    this.isFavorite = isFavorite;
  }

  String? getStatItem(key) {
    final statsPokemon =
        stats?.where((element) => element.stat.name == key).toList() ?? [];
    if (statsPokemon.isEmpty) return null;
    return (statsPokemon.first.baseStat).toString();
  }

  PokemonEntity({
    required this.id,
    required this.name,
    this.stats,
    this.types,
    this.weight,
    this.height,
    this.isFavorite,
  });
}
