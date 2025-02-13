import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/config/module_app.dart';
import 'package:pokemon_app/src/core/navigation/navigation_core.dart';

class NavigationCoreImpl implements NavigationCore {
  @override
  Future<bool>? maybePop<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.maybePop(result);
  }

  @override
  bool? canPop() {
    return navigatorKey.currentState?.canPop();
  }

  @override
  Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(String newRouteName, RoutePredicate predicate, {Object? arguments, newFlow = false}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  @override
  void popUntil(RoutePredicate predicate) {
    navigatorKey.currentState?.popUntil(predicate);
  }

  @override
  Future<T?>? popAndPushNamed<T extends Object?, TO extends Object?>(String routeName, {TO? result, Object? arguments, newFlow = false}) {
    return navigatorKey.currentState?.popAndPushNamed(routeName, result: result, arguments: arguments);
  }

  @override
  Future<T?>? pushNamed<T extends Object?>(String routeName, {Object? arguments, newFlow = false}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  @override
  void pop<T extends Object?>([T? result]) async {
    return navigatorKey.currentState?.pop(result);
  }

  @override
  Future<T?>? pushReplacementNamed<T extends Object?, TO extends Object?>(String routeName, {TO? result, Object? arguments, newFlow = false}) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments, result: result);
  }
}
