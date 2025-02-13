import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_pokemon.usecase.dart';

class GetPokemonUsecaseImpl implements GetPokemonUsecase {
  final PokemonsRepository _repository;
  GetPokemonUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, PokemonEntity>> call(String id) async {
    return await _repository.getPokemon(id);
  }
}
