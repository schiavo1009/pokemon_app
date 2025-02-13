import 'package:dartz/dartz.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';

abstract class GetPokemonsUsecase {
  Future<Either<Exception, List<PokemonEntity>>> call(
      {int? offset, int? limit});
}
