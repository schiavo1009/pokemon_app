import 'package:pokemon_app/src/core/config/module.dart';
import 'package:pokemon_app/src/core/routes/roues_core.dart';
import 'package:pokemon_app/src/core/shared/utils/register_singleton.dart';
import 'package:pokemon_app/src/modules/home/home_routes.dart';
import 'package:pokemon_app/src/modules/home/presentation/controllers/home_tab.controller.dart';

class HomeModule implements Module {
  @override
  List<RoutesCore> getRoutes() {
    return HomeRoutes.getRoutes(routePrefix: routePrefix);
  }

  @override
  void registerListeners() {}

  @override
  void registerSingletons() {
    RegisterSingleton.register<IHomeTabController>(HomeTabController());
  }

  @override
  String get routePrefix => '/home';
}
