import 'package:pokemon_app/src/core/routes/roues_core.dart';

abstract class Module {
  void registerSingletons();
  List<RoutesCore> getRoutes();
  void registerListeners();
  String get routePrefix;
}
