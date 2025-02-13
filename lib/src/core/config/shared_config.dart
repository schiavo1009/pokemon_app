import 'package:pokemon_app/src/core/endpoint/endpoints.core.dart';
import 'package:pokemon_app/src/core/navigation/navigation_core.dart';

class SharedConfigs {
  factory SharedConfigs({
   required  EndpointsCore endpoints,
   required NavigationCore navigation,
  }) {
    instance._endpoints = endpoints;
    instance._navigation = navigation;
    return instance;
  }
  SharedConfigs._();
  late EndpointsCore _endpoints;
  EndpointsCore get endpoints => _endpoints;
  late NavigationCore _navigation;
  NavigationCore get navigation => _navigation;

  static final instance = SharedConfigs._();
}
