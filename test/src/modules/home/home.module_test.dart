import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/src/core/config/module.dart';
import 'package:pokemon_app/src/modules/home/home_module.dart';
import 'package:pokemon_app/src/modules/home/home_routes.dart';
import 'package:pokemon_app/src/modules/home/presentation/controllers/home_tab.controller.dart';

void main() {
  late Module sut;

  setUpAll(() {
    sut = HomeModule();
  });

  test('Should verify with getRoutes return all routes of home', () {
    final routes = sut.getRoutes();
    final homeRoutes = HomeRoutes.getRoutes(routePrefix: sut.routePrefix);

    expect(routes.length, 1);
    expect(routes.length, homeRoutes.length);
    expect(routes.first.routeName, homeRoutes.first.routeName);
  });

  test('Should verify with registerSingletons register all singletons of home',
      () {
    sut.registerSingletons();
    expect(GetIt.I.isRegistered<IHomeTabController>(), true);
  });

  test('Should verify with routePrefix was defined', () {
    final routePrefix = sut.routePrefix;
    expect(routePrefix, '/home');
  });
}
