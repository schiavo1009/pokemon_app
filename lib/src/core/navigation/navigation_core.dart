import 'package:flutter/material.dart';

abstract class NavigationCore {
  void pop<T extends Object?>([T? result]);
  Future<T?>? pushReplacementNamed<T extends Object?, TO extends Object?>(String routeName, {TO? result, Object? arguments, newFlow = false});
  Future<T?>? pushNamed<T extends Object?>(String routeName, {Object? arguments, newFlow = false});

  Future<T?>? popAndPushNamed<T extends Object?, TO extends Object?>(String routeName, {TO? result, Object? arguments, newFlow = false});

  void popUntil(RoutePredicate predicate);

  Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(String newRouteName, RoutePredicate predicate, {Object? arguments, newFlow = false});

  Future<bool>? maybePop<T extends Object?>([T? result]);
  bool? canPop();
}
