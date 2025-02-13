import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon.model.dart';

abstract class FavoritePokemonsDatasource {
  Future<List<PokemonModel>> getPokemons();
  Future<PokemonModel> getPokemon(int id);
  Future<void> addPokemon(PokemonModel model);
  Future<void> removePokemon(int id);
}
