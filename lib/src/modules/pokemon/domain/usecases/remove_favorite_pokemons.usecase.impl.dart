import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/remove_favorite_pokemons.usecase.dart';

class RemoveFavoritePokemonsUsecaseImpl implements RemoveFavoritePokemonsUsecase {
  final FavoritePokemonsRepository _repository;
  RemoveFavoritePokemonsUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, void>> call(
      int id 
     ) async {
    return await _repository.removePokemon(id);
  }
}
