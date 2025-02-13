import 'package:pokemon_app/src/core/config/shared_config.dart';
import 'package:pokemon_app/src/core/shared/utils/state_page.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/remove_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/pokemon_routes.dart';
import 'package:rxdart/rxdart.dart';

abstract class IFavoritePokemonsController {
  Future<void> getFavoritePokemons();
  Future<void> removeFavoritePokemon({required int id});
  void goToPokemonDetail(int id);
  final BehaviorSubject<StatePage<List<PokemonEntity>>> state =
      BehaviorSubject<StatePage<List<PokemonEntity>>>();
}

class FavoritePokemonsController implements IFavoritePokemonsController {
  final GetFavoritePokemonsUsecase getFavoritesPokemonsUsecase;
  final RemoveFavoritePokemonsUsecase removeFavoritePokemonsUsecase;

  FavoritePokemonsController({
    required this.getFavoritesPokemonsUsecase,
    required this.removeFavoritePokemonsUsecase,
  });

  @override
  final BehaviorSubject<StatePage<List<PokemonEntity>>> state =
      BehaviorSubject<StatePage<List<PokemonEntity>>>();

  @override
  Future<void> getFavoritePokemons() async {
    state.value = StateLoading();
    final result = await getFavoritesPokemonsUsecase();
    result.fold((error) {
      state.value = StateError();
    }, (response) {
      if (response.isEmpty) {
        state.value = StateEmpty();
        return;
      }
      response = response.map((item) {
        item.changeIsFavorite(true);
        return item;
      }).toList();
      state.value = StateSuccess(data: response);
    });
  }

  @override
  Future<void> removeFavoritePokemon({required int id}) async {
    await removeFavoritePokemonsUsecase(id);
    final pokemons = state.value as StateSuccess<List<PokemonEntity>>;
    pokemons.data!.removeWhere((element) => element.id == id);
    if (pokemons.data!.isEmpty) {
      state.value = StateEmpty();
      return;
    }
    state.value = StateSuccess(data: pokemons.data);
  }

  @override
  void goToPokemonDetail(int id) {
    SharedConfigs.instance.navigation
        .pushNamed('${PokemonRoutes.pokemonDetailRoute}?id=$id');
  }
}
