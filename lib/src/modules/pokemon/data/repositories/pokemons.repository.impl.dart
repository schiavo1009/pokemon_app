import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/pokemons.datasource.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/pokemons.repository.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsDatasource _datasource;
  PokemonsRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<PokemonEntity>>> getPokemons(
      {int? offset, int? limit}) async {
    try {
      final result =
          await _datasource.getPokemons(offset: offset, limit: limit);
      return Right(result);
    } catch (error) {
      return Left(error as Exception);
    }
  }

  @override
  Future<Either<Exception, PokemonEntity>> getPokemon(String id) async {
    try {
      final result = await _datasource.getPokemon(id);
      return Right(result);
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
