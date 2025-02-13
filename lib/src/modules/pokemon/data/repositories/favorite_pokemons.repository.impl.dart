import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/favorite_pokemons.datasource.dart';
import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon.model.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';

class FavoritePokemonsRepositoryImpl implements FavoritePokemonsRepository {
  final FavoritePokemonsDatasource _datasource;
  FavoritePokemonsRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<PokemonEntity>>> getPokemons(
     ) async {
    try {
      final result = await _datasource.getPokemons();
      return Right(result);
    } catch (error) {
      return Left(error as Exception);
    }
  }
  
  @override
  Future<Either<Exception, void>> addPokemon(PokemonEntity entity) async {
     try {
      await _datasource.addPokemon(PokemonModel.fromEntity(entity));
      return Right(null);
    } catch (error) {
      return Left(error as Exception);
    }
  }
  
  @override
  Future<Either<Exception, void>> removePokemon(int id) async {
     try {
      await _datasource.removePokemon(id);
      return Right(null);
    } catch (error) {
      return Left(error as Exception);
    }
  }
  
  @override
  Future<Either<Exception, PokemonEntity>> getPokemon(int id) async {
     try {
      final result = await _datasource.getPokemon(id);
      return Right(result);
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
