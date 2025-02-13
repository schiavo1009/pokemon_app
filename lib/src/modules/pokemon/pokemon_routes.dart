import 'package:get_it/get_it.dart';
import 'package:pokemon_app/src/core/routes/roues_core.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/controllers/pokemon_detail.controller.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/controllers/pokemons.controller.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/pages/pokemon_detail.page.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/pages/pokemons.page.dart';

class PokemonRoutes {
  static List<RoutesCore> getRoutes({String? routePrefix}) {
    return [
      RoutesCore(
        routeName: list,
        page: (args, queryParameters) =>
            PokemonsPage(controller: GetIt.I.get<IPokemonsController>()),
        routePrefix: routePrefix,
      ),
      RoutesCore(
        routeName: pokemonDetail,
        page: (args, queryParameters) => PokemonDetailPage(
          controller: GetIt.I.get<IPokemonDetailController>(),
          id: queryParameters?['id'],
        ),
        routePrefix: routePrefix,
      ),
    ];
  }

  static String list = '/list';
  static String pokemonDetail = '/pokemon-detail';
  static String pokemonDetailRoute = '/pokemon/pokemon-detail';
}
