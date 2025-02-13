import 'package:pokemon_app/src/core/shared/utils/state_page.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_pokemon.usecase.dart';
import 'package:rxdart/rxdart.dart';

abstract class IPokemonDetailController {
  Future<void> getPokemonDetail(String? id);
  final BehaviorSubject<StatePage<PokemonEntity>> state =
      BehaviorSubject<StatePage<PokemonEntity>>();
}

class PokemonDetailController implements IPokemonDetailController {
  final GetPokemonUsecase getPokemonUsecase;
  PokemonDetailController({required this.getPokemonUsecase});
  @override
  final BehaviorSubject<StatePage<PokemonEntity>> state =
      BehaviorSubject<StatePage<PokemonEntity>>();

  @override
  Future<void> getPokemonDetail(String? id) async {
    if (id == null) {
      state.value = StateEmpty();
      return;
    }
    state.value = StateLoading();
    final result = await getPokemonUsecase(id);
    result.fold((error) {
      state.value = StateError();
    }, (response) {
      state.value = StateSuccess(data: response);
    });
  }
}
