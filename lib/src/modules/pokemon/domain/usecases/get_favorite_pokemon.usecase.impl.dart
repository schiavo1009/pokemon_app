import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemon.usecase.dart';

class GetFavoritePokemonUsecaseImpl implements GetFavoritePokemonUsecase {
  final FavoritePokemonsRepository _repository;
  GetFavoritePokemonUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, PokemonEntity>> call(int id
     ) async {
    return await _repository.getPokemon(id);
  }
}
