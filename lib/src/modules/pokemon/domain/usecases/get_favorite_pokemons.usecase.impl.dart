import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemons.usecase.dart';

class GetFavoritePokemonsUsecaseImpl implements GetFavoritePokemonsUsecase {
  final FavoritePokemonsRepository _repository;
  GetFavoritePokemonsUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, List<PokemonEntity>>> call(
     ) async {
    return await _repository.getPokemons();
  }
}
