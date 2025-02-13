import 'package:pokemon_app/src/core/routes/app_routes.dart';
import 'package:pokemon_app/src/core/config/shared_config.dart';

abstract class SplashController {
 void goHome();
}

class SplashControllerImpl implements SplashController {
  SplashControllerImpl();

  @override
  void goHome() async {
    await Future.delayed(const Duration(milliseconds: 3000));
        SharedConfigs.instance.navigation.pushNamed(AppRoutes.home);
  }
}
