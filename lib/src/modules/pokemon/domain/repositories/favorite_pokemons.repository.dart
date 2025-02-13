import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';

abstract class FavoritePokemonsRepository {
  Future<Either<Exception, List<PokemonEntity>>> getPokemons();
  Future<Either<Exception, PokemonEntity>> getPokemon(int id);
  Future<Either<Exception, void>> addPokemon(PokemonEntity entity);
  Future<Either<Exception, void>> removePokemon(int id);
}
