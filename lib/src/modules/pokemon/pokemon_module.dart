import 'package:get_it/get_it.dart';
import 'package:pokemon_app/src/core/config/module.dart';
import 'package:pokemon_app/src/core/db/db_client.dart';
import 'package:pokemon_app/src/core/routes/roues_core.dart';
import 'package:pokemon_app/src/core/shared/utils/register_singleton.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/favorite_pokemons.datasource.dart';
import 'package:pokemon_app/src/modules/pokemon/data/repositories/favorite_pokemons.repository.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/add_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/add_favorite_pokemons.usecase.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemon.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemon.usecase.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemons.usecase.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_pokemon.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_pokemon.usecase.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/remove_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/remove_favorite_pokemons.usecase.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/internal/favorite_pokemons.datasource.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/pokemon_routes.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/pokemons.datasource.dart';
import 'package:pokemon_app/src/modules/pokemon/data/repositories/pokemons.repository.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_pokemons.usecase.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/external/pokemons.datasource.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/controllers/favorite_pokemons.controller.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/controllers/pokemon_detail.controller.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/controllers/pokemons.controller.dart';
import 'package:pokemon_app/src/modules/pokemon/db/pokemon_datasource_client.dart';

class PokemonModule implements Module {
  @override
  List<RoutesCore> getRoutes() {
    return PokemonRoutes.getRoutes(routePrefix: routePrefix);
  }

  @override
  void registerListeners() {}

  @override
  void registerSingletons() {
    RegisterSingleton.register<DbClient>(
        PokemonDbClientImpl());
    RegisterSingleton.register<FavoritePokemonsDatasource>(
        FavoritePokemonsDatasourceImpl(GetIt.I.get()));
    RegisterSingleton.register<FavoritePokemonsRepository>(
        FavoritePokemonsRepositoryImpl(GetIt.I.get()));
    RegisterSingleton.register<GetFavoritePokemonsUsecase>(
        GetFavoritePokemonsUsecaseImpl(GetIt.I.get()));
    RegisterSingleton.register<GetFavoritePokemonUsecase>(
        GetFavoritePokemonUsecaseImpl(GetIt.I.get()));
    RegisterSingleton.register<AddFavoritePokemonsUsecase>(
      AddFavoritePokemonsUsecaseImpl(GetIt.I.get()));
    RegisterSingleton.register<RemoveFavoritePokemonsUsecase>(
        RemoveFavoritePokemonsUsecaseImpl(GetIt.I.get()));
    RegisterSingleton.register<PokemonsDatasource>(
        PokemonsDatasourceImpl(GetIt.I.get()));
    RegisterSingleton.register<PokemonsRepository>(
        PokemonsRepositoryImpl(GetIt.I.get()));
     RegisterSingleton.register<GetPokemonsUsecase>(
        GetPokemonsUsecaseImpl(GetIt.I.get()));
    RegisterSingleton.register<GetPokemonUsecase>(
        GetPokemonUsecaseImpl(GetIt.I.get()));
    RegisterSingleton.register<IPokemonsController>(PokemonsController(getPokemonsUsecase: GetIt.I.get(), getFavoritesPokemonsUsecase: GetIt.I.get(), addFavoritePokemonsUsecase: GetIt.I.get(), removeFavoritePokemonsUsecase: GetIt.I.get()));
    RegisterSingleton.register<IFavoritePokemonsController>(FavoritePokemonsController(
      getFavoritesPokemonsUsecase: GetIt.I.get(),
      removeFavoritePokemonsUsecase: GetIt.I.get(),
    ));
    RegisterSingleton.register<IPokemonDetailController>(
        PokemonDetailController(
          getPokemonUsecase: GetIt.I.get(),

     ));

  }

  @override
  String get routePrefix => '/pokemon';
}
