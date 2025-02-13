import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/add_favorite_pokemons.usecase.dart';

class AddFavoritePokemonsUsecaseImpl implements AddFavoritePokemonsUsecase {
  final FavoritePokemonsRepository _repository;
  AddFavoritePokemonsUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, void>> call(
      PokemonEntity entity 
     ) async {
    return await _repository.addPokemon(entity);
  }
}
