import 'package:pokemon_app/src/core/db/db_client.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/favorite_pokemons.datasource.dart';
import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon.model.dart';

class FavoritePokemonsDatasourceImpl implements FavoritePokemonsDatasource {
  final DbClient _db;
  FavoritePokemonsDatasourceImpl(this._db);

  @override
  Future<List<PokemonModel>> getPokemons({int? offset, int? limit}) async {
    try {
      var result = await _db.query();
      return result.map((json) => PokemonModel(json)).toList();
    } catch (error) {
      return throw Exception(error);
    }
  }

  @override
  Future<void> addPokemon(PokemonModel model) async {
    await _db.insert(model.toJson());
  }

  @override
  Future<void> removePokemon(int id) async {
    await _db.delete(id);
  }

  @override
  Future<PokemonModel> getPokemon(int id) async {
    try {
      final map = await _db.getItemFromID(id.toString());
      return PokemonModel(map!);
    } catch (error) {
      return throw Exception(error);
    }
  }
}
