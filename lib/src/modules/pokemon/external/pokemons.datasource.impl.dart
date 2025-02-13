import 'package:dio/dio.dart';
import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon.model.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/pokemons.datasource.dart';

class PokemonsDatasourceImpl implements PokemonsDatasource {
  static const String route = '/pokemon';
  final Dio _dio;
  PokemonsDatasourceImpl(this._dio);

  @override
  Future<List<PokemonModel>> getPokemons({int? offset, int? limit}) async {
    try {
      final result = await _dio.get(route, queryParameters: {
        "offset": offset,
        "limit": limit,
      });
      final List list = result.data["results"];
      return list.asMap().entries.map((entry) {
        final json = entry.value;
        return PokemonModel(json, id: entry.key + 1 + (offset ?? 0));
      }).toList();
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<PokemonModel> getPokemon(String id) async {
    try {
      final result = await _dio.get('$route/$id');
      return PokemonModel(result.data);
    } catch (error) {
      throw Exception(error);
    }
  }
}
