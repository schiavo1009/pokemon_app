import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon.model.dart';

abstract class PokemonsDatasource {
  Future<List<PokemonModel>> getPokemons({int? offset, int? limit});
  Future<PokemonModel> getPokemon(String id);
}
