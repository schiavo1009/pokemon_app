import 'package:get_it/get_it.dart';

class RegisterSingleton {

  static void register<T extends Object>(
    T instance, {
    String? instanceName,
  }) {
    if (!GetIt.I.isRegistered<T>(instanceName: instanceName)) {
      GetIt.I
          .registerLazySingleton<T>(() => instance, instanceName: instanceName);
    }
  }

}