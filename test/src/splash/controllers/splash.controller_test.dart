import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/core/config/shared_config.dart';
import 'package:pokemon_app/src/core/endpoint/endpoints.core.dart';
import 'package:pokemon_app/src/core/navigation/navigation_core.dart';
import 'package:pokemon_app/src/core/routes/app_routes.dart';
import 'package:pokemon_app/src/splash/splash.controller.dart';

class NavigationCoreMock extends Mock implements NavigationCore {}

class EndpointsCoreMock extends Mock implements EndpointsCore {}

void main() {
  late SplashController controller;
  late NavigationCoreMock navigation;
  late EndpointsCore endpoint;
  setUpAll(() {
    controller = SplashControllerImpl();
    navigation = NavigationCoreMock();
    endpoint = EndpointsCoreMock();
    SharedConfigs(navigation: navigation, endpoints: endpoint);
  });

  test('goHome should navigate to home after 3 seconds', () async {
  
    when(() => navigation.pushNamed(AppRoutes.home))
        .thenAnswer((_) async => true);
   
    controller.goHome();
 
    verifyNever(() => navigation.pushNamed(AppRoutes.home));
    await Future.delayed(const Duration(milliseconds: 3000));
    verify(() => navigation.pushNamed(AppRoutes.home)).called(1);
  });
}
