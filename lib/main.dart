import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/config/module.dart';
import 'package:pokemon_app/src/core/config/module_app.dart';
import 'package:pokemon_app/src/core/constants/colors_system.dart';
import 'package:pokemon_app/src/core/endpoint/endpoint_core_impl.dart';
import 'package:pokemon_app/src/core/navigation/navigation_core_impl.dart';
import 'package:pokemon_app/src/core/routes/app_routes.dart';
import 'package:pokemon_app/src/core/routes/roues_core.dart';
import 'package:pokemon_app/src/core/config/shared_config.dart';
import 'package:pokemon_app/src/core/shared/utils/register_singleton.dart';
import 'package:pokemon_app/src/modules/home/home_module.dart';
import 'package:pokemon_app/src/modules/pokemon/pokemon_module.dart';
import 'package:pokemon_app/src/splash/splash.controller.dart';
import 'package:pokemon_app/src/splash/splash.page.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget with ModuleApp {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MockEndpoint.setMockEnable(true);
    SharedConfigs(
      endpoints: EndpointsCoreImpl(),
      navigation: NavigationCoreImpl(),
    );
    registerMicroappConfigs();
   
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: ColorsSystem.primary,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: super.generateRoute,
      initialRoute: AppRoutes.splash,
    );
  }

  @override
  List<RoutesCore> get baseRoutes => [
        RoutesCore(
          routeName: AppRoutes.splash,
          page: (args, queryParameters) => SplashPage(
              controller:
                  SplashControllerImpl()),
        ),
      ];

  @override
  List<Module> get modules => [
    HomeModule(),
    PokemonModule(),
      ];

  @override
  void registerGlobalInjections() {
    RegisterSingleton.register<Dio>(Dio(BaseOptions(baseUrl: SharedConfigs.instance.endpoints.basePath,),),);
  }

  @override
  void registerGlobalListeners() {}
}
