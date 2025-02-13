import 'package:get_it/get_it.dart';
import 'package:pokemon_app/src/core/routes/roues_core.dart';
import 'package:pokemon_app/src/modules/home/presentation/controllers/home_tab.controller.dart';
import 'package:pokemon_app/src/modules/home/presentation/pages/home_tab.page.dart';

class HomeRoutes {
  static List<RoutesCore> getRoutes({String? routePrefix}) {
    return [
      RoutesCore(
        routeName: homeTabRoute,
        page: (args, queryParameters) => HomeTabPage(controller: GetIt.I.get<IHomeTabController>()),
        routePrefix: routePrefix,
      ),
    ];
  }

  static String homeTabRoute = '/home-tab';
}
