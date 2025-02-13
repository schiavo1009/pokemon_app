import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';

abstract class PokemonsRepository {
  Future<Either<Exception, List<PokemonEntity>>> getPokemons(
      {int? offset, int? limit});
  Future<Either<Exception, PokemonEntity>> getPokemon(String id);
}
