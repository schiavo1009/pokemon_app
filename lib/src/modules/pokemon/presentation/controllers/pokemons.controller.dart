import 'package:pokemon_app/src/core/config/shared_config.dart';
import 'package:pokemon_app/src/core/shared/utils/state_page.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/add_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/remove_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/pokemon_routes.dart';
import 'package:rxdart/rxdart.dart';

abstract class IPokemonsController {
  Future<void> getPokemons({bool getMoreItens = false});
  Future<void> updateFavoritePokemon({required int id});
  void goToPokemonDetail(int id);
  final BehaviorSubject<StatePage<List<PokemonEntity>>> state =
      BehaviorSubject<StatePage<List<PokemonEntity>>>();
}

class PokemonsController implements IPokemonsController {
  final GetPokemonsUsecase getPokemonsUsecase;
  final GetFavoritePokemonsUsecase getFavoritesPokemonsUsecase;
  final AddFavoritePokemonsUsecase addFavoritePokemonsUsecase;
  final RemoveFavoritePokemonsUsecase removeFavoritePokemonsUsecase;

  List<PokemonEntity>? favoritePokemons;
  PokemonsController({
    required this.getPokemonsUsecase,
    required this.getFavoritesPokemonsUsecase,
    required this.addFavoritePokemonsUsecase,
    required this.removeFavoritePokemonsUsecase,
  });

  @override
  final BehaviorSubject<StatePage<List<PokemonEntity>>> state =
      BehaviorSubject<StatePage<List<PokemonEntity>>>();

  @override
  Future<void> getPokemons({bool getMoreItens = false}) async {
    int offset = 0;
    List<PokemonEntity> pokemonList = [];
    if (getMoreItens && state.value is StateSuccess<List<PokemonEntity>>) {
      pokemonList =
          (state.value as StateSuccess<List<PokemonEntity>>).data ?? [];
      offset = pokemonList.length;
      state.value = StateSuccess(data: pokemonList, isLoadingMore: true);
    } else {
      state.value = StateLoading();
    }
    await getFavoritePokemons();
    final result = await getPokemonsUsecase(offset: offset, limit: 20);
    result.fold((error) {
      state.value = StateError();
    }, (response) {
      response = createListWithFavoritePokemons(response);
      pokemonList.addAll(response);
      state.value = StateSuccess(data: pokemonList, isLoadingMore: false);
    });
  }

  Future<void> addFavoritePokemon({required int id}) async {
    final pokemons =
        (state.value as StateSuccess<List<PokemonEntity>>).data ?? [];
    await addFavoritePokemonsUsecase(pokemons[id - 1]);
  }

  Future<void> removeFavoritePokemon({required int id}) async {
    await removeFavoritePokemonsUsecase(id);
  }

  Future<void> getFavoritePokemons() async {
    final result = await getFavoritesPokemonsUsecase();
    result.fold((error) {}, (response) {
      favoritePokemons = response;
    });
  }

  List<PokemonEntity> createListWithFavoritePokemons(
      List<PokemonEntity> pokemons) {
    if (favoritePokemons == null) return pokemons;
    return pokemons.map((pokemon) {
      final isFavorite =
          favoritePokemons!.any((element) => element.id == pokemon.id);
      pokemon.changeIsFavorite(isFavorite);
      return pokemon;
    }).toList();
  }

  @override
  Future<void> updateFavoritePokemon({required int id}) async {
    final pokemonList =
        (state.value as StateSuccess<List<PokemonEntity>>).data ?? [];
    if (pokemonList[id - 1].isFavorite == true) {
      pokemonList[id - 1].changeIsFavorite(false);
      removeFavoritePokemon(id: id);
    } else {
      pokemonList[id - 1].changeIsFavorite(true);
      addFavoritePokemon(id: id);
    }
    state.value = StateSuccess(data: pokemonList);
  }

  @override
  void goToPokemonDetail(int id) {
    SharedConfigs.instance.navigation
        .pushNamed('${PokemonRoutes.pokemonDetailRoute}?id=$id');
  }
}
