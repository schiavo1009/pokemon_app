import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/config/module.dart';
import 'package:pokemon_app/src/core/routes/page_transition.dart';
import 'package:pokemon_app/src/core/routes/roues_core.dart';

mixin ModuleApp {
  List<Module> get modules;
  List<RoutesCore> get baseRoutes;
  final List<RoutesCore> routes = [];

  void registerGlobalInjections();
  void registerGlobalListeners();

  void _registerRouters() {
    if (baseRoutes.isNotEmpty) routes.addAll(baseRoutes);
    if (modules.isNotEmpty) {
      for (final microapp in modules) {
        routes.addAll(microapp.getRoutes());
      }
    }
  }

  void _registerInjections() {
    if (modules.isNotEmpty) {
      for (final microapp in modules) {
        microapp.registerSingletons();
      }
    }
  }

  void _registerListeners() {
    if (modules.isNotEmpty) {
      for (final microapp in modules) {
        microapp.registerListeners();
      }
    }
  }

  void registerMicroappConfigs() {
    registerGlobalInjections();
    _registerInjections();
    registerGlobalListeners();
    _registerListeners();
    _registerRouters();
  }

  String routerNameLast = '';

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final routerArgs = settings.arguments;
    routerNameLast = settings.name ?? '';
    final uri = Uri.parse(settings.name ?? '');
    final queryParameters = uri.queryParameters;
    final routerName = uri.path;
    final list = routes.where(
      (element) => ((element.routePrefix ?? '') + element.routeName) == routerName,
    );
    if (list.isEmpty) return null;

    final navigateTo = list.first;
    if (navigateTo.transition == RouteTransition.defaultTransition) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => navigateTo.routePage(context, routerArgs, queryParameters),
      );
    } else {
      return PageTransition(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => navigateTo.routePage(context, routerArgs, queryParameters),
        type: navigateTo.transition,
        builder: (context) => navigateTo.routePage(context, routerArgs, queryParameters),
      );
    }
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
