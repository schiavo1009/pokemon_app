import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/pokemons.repository.dart';
import 'get_pokemons.usecase.dart';

class GetPokemonsUsecaseImpl implements GetPokemonsUsecase {
  final PokemonsRepository _repository;
  GetPokemonsUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, List<PokemonEntity>>> call(
      {int? offset, int? limit}) async {
    return await _repository.getPokemons(offset: offset, limit: limit);
  }
}
