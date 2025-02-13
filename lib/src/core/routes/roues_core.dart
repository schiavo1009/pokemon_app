import 'package:flutter/material.dart';

class RoutesCore {
  RoutesCore({
    this.transition = RouteTransition.defaultTransition,
    required this.page,
    required this.routeName,
    this.routePrefix,
  });
  String routeName;
  String? routePrefix;
  Widget Function(Object? args, Map? queryParameters) page;

  RouteTransition transition;
  Widget Function(BuildContext context, Object? args, Map? queryParameters) get routePage => (context, args, queryParameters) => page(args, queryParameters);
}

enum RouteTransition {
  defaultTransition,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
  none
}
