import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon_stats.model.dart';
import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon_types.model.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';

class PokemonModel extends PokemonEntity {
  factory PokemonModel(Map<String, dynamic> json, {int? id}) {
    return PokemonModel._(
      id: json['id'] ?? id,
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      stats: json['stats'] == null
          ? null
          : (json['stats'] as List)
              .map((element) => PokemonStatsModel(element))
              .toList(),
      types: json['types'] == null
          ? null
          : (json['types'] as List)
              .map((element) => PokemonTypesModel(element))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static PokemonModel fromEntity(PokemonEntity entity) => PokemonModel._(
        id: entity.id,
        name: entity.name,
      );

  PokemonModel._({
    required super.id,
    required super.name,
    super.height,
    super.weight,
    super.stats,
    super.types,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonModel && other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
